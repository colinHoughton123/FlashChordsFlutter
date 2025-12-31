import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/services/update_check_service.dart';

import 'package:flashchords/features/config/config_screen.dart';
import 'package:flashchords/features/flashcard/flashcard_screen.dart';
import 'package:flashchords/features/welcome/language_picker_dialog.dart';

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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeShowUpdateDialog();
    });

    _loadChords();
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
            onPressed: () {
              // App Store / Play Store launch later
              Navigator.pop(context);
            },
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
                      // ───────── TITLE ─────────
                      Text(
                        'FlashChords',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ───────── START BUTTON ─────────
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.flash_on),
                          label: Text(t.start),
                          onPressed: _preloadedItems == null
                              ? null
                              : () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => FlashcardScreen(
                                        items: _preloadedItems!,
                                        userPressedStart: true,
                                      ),
                                    ),
                                  );
                                },
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ───────── CATCH PHRASE ─────────
                      Text(
                        t.mainCatchPhrase,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),

                      const SizedBox(height: 24),

                      // ───────── FEATURES ─────────
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          t.mainFeaturesTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      _featureBox(
                        icon: Icons.music_note,
                        iconColor: Colors.deepPurple,
                        title: t.mainFeatures1Title,
                        content: t.mainFeatures1Content,
                      ),

                      const SizedBox(height: 10),

                      _featureBox(
                        icon: Icons.timer_outlined,
                        iconColor: Colors.orange,
                        title: t.mainFeatures2Title,
                        content: t.mainFeatures2Content,
                      ),

                      const SizedBox(height: 10),

                      _featureBox(
                        icon: Icons.mic,
                        iconColor: Colors.green,
                        title: t.mainFeatures3Title,
                        content: t.mainFeatures3Content,
                      ),

                      const SizedBox(height: 24),

                      // ───────── CONFIGURE ─────────
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