import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flashchords/data/settings_repository.dart';

import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/services/update_check_service.dart';
import 'package:flashchords/core/free_listener_usage.dart';

import 'package:flashchords/features/config/config_screen.dart';
import 'package:flashchords/features/debug/key_calibration_screen.dart';
import 'package:flashchords/features/flashcard/flashcard_screen.dart';
import 'package:flashchords/features/welcome/language_picker_dialog.dart';
import 'package:flashchords/widgets/upgrade_dialog.dart';

import 'package:flashchords/models/flashcard_item.dart';
import 'package:flashchords/data/chord_xml_parser.dart';



class WelcomeScreen extends StatefulWidget {
  final Future<void> Function(String) onLanguageChanged;

  const WelcomeScreen({
    super.key,
    required this.onLanguageChanged,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _loadingChords = false;
  List<FlashcardItem>? _preloadedItems;

  FreeListenerUsage? _listenerUsage;
  bool _isUpgraded = false;

  // ─────────────────────────────
  // DEV / EMULATED UPGRADE KEYS
  // ─────────────────────────────
  static const _isUpgradedKey = 'is_upgraded';
  static const _listenerEnabledKey = 'listener_enabled';

  // ─────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _maybeShowUpdateDialog();
      await _loadListenerUsage();
    });

    _loadChords();
  }

  /// 🔑 Refresh when returning to this screen
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadListenerUsage();
  }

  // ─────────────────────────────
  // DATA LOADERS
  // ─────────────────────────────

  Future<void> _loadListenerUsage() async {
    final usage = FreeListenerUsage();
    await usage.load();
    final isUpgraded = await SettingsRepository().loadIsUpgraded();

    if (!mounted) return;
    setState(() {
      _listenerUsage = usage;
      _isUpgraded = isUpgraded;
    });
  }

  /// 🧪 DEV: emulate upgrade / downgrade
  Future<void> _setUpgraded(bool value) async {
  final repo = SettingsRepository();
  await repo.saveIsUpgraded(value);

  debugPrint(value
      ? '🟢 DEV: UPGRADE ENABLED'
      : '🧪 DEV: UPGRADE DISABLED');

  await _loadListenerUsage(); // refresh UI
}

  Future<void> _maybeShowUpdateDialog() async {
    final result = await UpdateCheckService.check();
    if (!mounted || result == null || !result.hasUpdate) return;

    final t = AppLocalizations.of(context)!;

    await showDialog(
      context: context,
      barrierDismissible: !result.mustUpdate,
      builder: (_) => AlertDialog(
        title: Text(result.title),
        content: Text(result.body),
        actions: [
          if (!result.mustUpdate)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(t.welcomeUpdate_Button_Later),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.welcomeUpdate_Button_Update),
          ),
        ],
      ),
    );
  }

  Future<void> _loadChords() async {
    setState(() => _loadingChords = true);
    try {
      _preloadedItems = await loadFlashcardsFromXml();
    } finally {
      if (mounted) {
        setState(() => _loadingChords = false);
      }
    }
  }


  Future<void> _devResetAllPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Explicitly reset listener inversion notice dismissal.
    await SettingsRepository().saveListenerInversionNoticeDismissed(false);
    debugPrint('🧹 DEV RESET: all SharedPreferences cleared');
  }

  // ─────────────────────────────
  // BUILD
  // ─────────────────────────────

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.language),
          color: Colors.teal,
          tooltip: t.language_change_tooltip,
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => LanguagePickerDialog(
                onSelected: (code) async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('preferred_language', code);
                  widget.onLanguageChanged(code);
                },
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            color: Colors.teal,
            tooltip: t.howItWorksTitle,
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  title: Text(t.howItWorksTitle),
                  content: SizedBox(
                    width: 320,
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Text(t.howItWorksBody),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(t.configOK),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Center(
                child: Container(
                  width: 330,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 12,
                        offset: Offset(0, 6),
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const KeyCalibrationScreen(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade700,
                            ),
                            children: const [
                              TextSpan(text: 'FlashChords'),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.top,
                                child: Text(
                                  '™',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        t.mainCatchPhrase,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.flash_on),
                          label: Text(t.start),
                          onPressed: _preloadedItems == null
                              ? null
                              : () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => FlashcardScreen(
                                        items: _preloadedItems!,
                                        userPressedStart: true,
                                      ),
                                    ),
                                  );

                                  // 🔄 Refresh on return
                                  await _loadListenerUsage();
                                },
                        ),
                      ),

                      const SizedBox(height: 16),

                      const SizedBox(height: 24),

                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          t.mainFeaturesTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// 🟢 DEV: TAP → UPGRADE ON
                      /// 🟢 DEV: TAP → UPGRADE ON
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async => _setUpgraded(true),
                        child: _featureBox(
                          icon: Icons.music_note,
                          iconColor: Colors.deepPurple,
                          title: t.mainFeatures1Title,
                          content: t.mainFeatures1Content,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// 🧪 DEV: TAP → UPGRADE OFF
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async => _setUpgraded(false),
                        child: _featureBox(
                          icon: Icons.timer_outlined,
                          iconColor: Colors.orange,
                          title: t.mainFeatures2Title,
                          content: t.mainFeatures2Content,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// 🔥 TEMP RESET (listener usage)
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {
                          final usage = FreeListenerUsage();
                          await usage.reset();
                          // 2️⃣ CLEAR ALL SHARED PREFERENCES
                          await _devResetAllPrefs();

                          await _loadListenerUsage();
                        },
                        child: _featureBox(
                          icon: Icons.mic,
                          iconColor: Colors.green,
                          title: t.mainFeatures3Title,
                          content: t.mainFeatures3Content,
                        ),
                      ),

                      if (_listenerUsage != null) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            t.freeUsageStatus(
                              _listenerUsage!.limit,
                              _listenerUsage!.played,
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        if (_listenerUsage!.isLimitReached)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: GestureDetector(
                              onTap: () {
                                showUpgradeRequiredDialog(
                                  context: context,
                                  t: t,
                                  limit: _listenerUsage!.limit,
                                );
                              },
                              child: Text(
                                t.upgradeReenableListener,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                      ],

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ConfigScreen(),
                              ),
                            );
                          },
                          child: Text(t.configure),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// Feature tile helper
// ─────────────────────────────────────────
Widget _featureBox({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String content,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12, top: 2),
          child: Icon(icon, size: 28, color: iconColor),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
