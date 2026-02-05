import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // listEquals
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/data/settings_repository.dart';
import 'package:flashchords/core/system_error.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flashchords/l10n/app_localizations_extensions.dart';

import 'package:flashchords/core/free_listener_usage.dart';

class ConfigScreen extends ConsumerStatefulWidget {
  const ConfigScreen({super.key});

  @override
  ConsumerState<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends ConsumerState<ConfigScreen> {
  // --------------------------
  // HELPERS
  // --------------------------

  List<String> _sanitizeList(List<String> loaded, List<String> allowed) {
    final cleaned = loaded.where((v) => allowed.contains(v)).toList();
    if (cleaned.isEmpty) return [...allowed];
    return cleaned;
  }

  bool _isUpgraded = false;
  // --------------------------
  // DATA
  // --------------------------

  final List<String> _roots = [
    "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"
  ];

  final List<String> _chordTypes = [
    "major",
    "minor",
    "diminished",
    "augmented",
    "dominant7",
    "major7",
    "minor7",
    "suspended2",
    "suspended4",
  ];

  final List<String> _inversions = ["root", "first", "second"];

  List<String> _selectedRoots = [];
  List<String> _selectedChordTypes = [];
  List<String> _selectedInversions = [];

  bool _timerEnabled = false;
  int _timerSeconds = 5;
  bool _listenEnabled = false;
  String _cardOrder = "random";

  bool _listenerBlocked = false;
  FreeListenerUsage? _listenerUsage;
  bool _listenerInversionNoticeDismissed = false;

  late _ConfigSnapshot _initialConfig;

  // --------------------------
  // LIFECYCLE
  // --------------------------

  @override
  void initState() {
    super.initState();
    _loadSavedConfig();
  }


// --------------------------
// CHICKLET UI
// --------------------------

Widget _buildChickletGroup({
  required List<String> values,
  required List<String> selected,
  required String Function(String) labelBuilder,
}) {
  final t = AppLocalizations.of(context)!;

  return Wrap(
    spacing: 14,
    runSpacing: 14,
    children: values.map((value) {
      final isSelected = selected.contains(value);

      return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          setState(() {
            _toggleChipWithGuard(
              list: selected,
              value: value,
              selected: !isSelected,
              t: t,
            );
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.20),
                blurRadius: 8,
                offset: const Offset(3, 5),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isSelected
                      ? const [
                          Color(0xFFF4F0FF),
                          Color(0xFFE1DBFA),
                        ]
                      : const [
                          Color(0xFFFFFFFF),
                          Color(0xFFF0F0F3),
                        ],
                ),
              ),
              child: Text(
                labelBuilder(value),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? const Color(0xFF4B3FBF)
                      : const Color(0xFF3A3A3C),
                ),
              ),
            ),
          ),
        ),
      );
    }).toList(),
  );
}


// --------------------------
// TOGGLE GUARD
// --------------------------

Future<void> _showAtLeastOneRequiredDialog(AppLocalizations t) async {
  await showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(t.configTitle),
      content: Text(t.configAtLeastOneOption),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.configOK),
        ),
      ],
    ),
  );
}

void _toggleChipWithGuard({
  required List<String> list,
  required String value,
  required bool selected,
  required AppLocalizations t,
}) {
  final wasSelected = list.contains(value);
  final isLastSelected = list.length == 1 && wasSelected;

  if (!selected && isLastSelected) {
    _showAtLeastOneRequiredDialog(t);
    return;
  }

  if (selected && !wasSelected) {
    list.add(value);
  } else if (!selected && wasSelected) {
    list.remove(value);
  }

  // Show listener notice when inversions > 1 and listener is enabled.
  if (list == _selectedInversions) {
    _maybeShowListenerInversionNotice(t);
  }
}

Future<void> _maybeShowListenerInversionNotice(AppLocalizations t) async {
  if (!mounted) return;
  if (_listenerInversionNoticeDismissed) return;
  if (!_listenEnabled) return;
  if (_selectedInversions.length <= 1) return;

  bool dontShowAgain = false;

  await showDialog<void>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(t.listenerInversionNoticeTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(decoration: TextDecoration.none),
                    children: [
                      TextSpan(text: t.listenerInversionNoticePart1),
                      TextSpan(
                        text: t.listenerInversionNoticeAny,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      TextSpan(text: t.listenerInversionNoticePart2),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(t.listenerInversionNoticeDontShow),
                  value: dontShowAgain,
                  onChanged: (v) {
                    setDialogState(() {
                      dontShowAgain = v ?? false;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (dontShowAgain) {
                    final repo = SettingsRepository();
                    await repo.saveListenerInversionNoticeDismissed(true);
                    if (!mounted) return;
                    setState(() {
                      _listenerInversionNoticeDismissed = true;
                    });
                  }
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
                child: Text(t.listenerInversionNoticeGotIt),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> _loadSavedConfig() async {
  final repo = SettingsRepository();

  // Load listener usage
  final usage = FreeListenerUsage();
  await usage.load();
  _listenerUsage = usage;

  // 🔑 Load upgrade flag
  _isUpgraded = await repo.loadIsUpgraded();

  // 🔒 Block listener ONLY if not upgraded AND limit reached
  final listenerBlocked = !_isUpgraded && usage.isLimitReached;

  _listenEnabled = await repo.loadListenMode();
  if (listenerBlocked) {
    _listenEnabled = false;
    await repo.saveListenMode(false);
  }
  _listenerInversionNoticeDismissed =
      await repo.loadListenerInversionNoticeDismissed();

  _selectedRoots = _sanitizeList(await repo.loadRoots(), _roots);
  _selectedChordTypes =
      _sanitizeList(await repo.loadChordTypes(), _chordTypes);
  _selectedInversions =
      _sanitizeList(await repo.loadInversions(), _inversions);

  final timer = await repo.loadTimer();
  _timerEnabled = timer.$1;
  _timerSeconds = timer.$2;

  _cardOrder = await repo.loadCardOrder();

  _initialConfig = _ConfigSnapshot.fromState(this);
  setState(() {});
}

  // --------------------------
  // UNSAVED CHANGES
  // --------------------------

  bool get _hasUnsavedChanges =>
      !_ConfigSnapshot.fromState(this).equals(_initialConfig);

  Future<bool> _confirmDiscardChanges(AppLocalizations t) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.summary_unsaved_changes_title),
        content: Text(t.summary_unsaved_changes_body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.summary_discard),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // --------------------------
  // BUILD
  // --------------------------

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () async {
        if (!_hasUnsavedChanges) return true;
        return await _confirmDiscardChanges(t);
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text(t.configTitle),
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () async {
              if (_hasUnsavedChanges) {
                final discard = await _confirmDiscardChanges(t);
                if (!discard) return;
              }
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildChickletGroup(
                  values: _roots,
                  selected: _selectedRoots,
                  labelBuilder: (v) => v,
                ),

                const SizedBox(height: 24),

                _sectionTitle(t.configSelectChordTypes),
                _buildChickletGroup(
                  values: _chordTypes,
                  selected: _selectedChordTypes,
                  labelBuilder: (v) => _localizedChordType(v, t),
                ),

                const SizedBox(height: 24),

                _sectionTitle(t.configSelectInversions),
                _buildChickletGroup(
                  values: _inversions,
                  selected: _selectedInversions,
                  labelBuilder: (v) => _localizedInversion(v, t),
                ),

                const Divider(height: 36),

                _sectionTitle(t.configCardOrder),
                RadioListTile(
                  title: Text(t.configCardOrderRandom),
                  value: "random",
                  groupValue: _cardOrder,
                  onChanged: (v) => setState(() => _cardOrder = v!),
                ),
                RadioListTile(
                  title: Text(t.configCardOrderSorted),
                  value: "sorted",
                  groupValue: _cardOrder,
                  onChanged: (v) => setState(() => _cardOrder = v!),
                ),

                const Divider(height: 36),

                _buildTimerEnableCheckbox(),

                if (_timerEnabled)
                  _buildTimerSlider(t.configTimerSeconds),

                const Divider(),

                _buildListenModeCheckbox(),

                const SizedBox(height: 36),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final repo = SettingsRepository();

                      await repo.saveRoots(_selectedRoots);
                      await repo.saveChordTypes(_selectedChordTypes);
                      await repo.saveInversions(_selectedInversions);
                      await repo.saveTimer(_timerEnabled, _timerSeconds);
                      await repo.saveListenMode(_listenEnabled);
                      await repo.saveCardOrder(_cardOrder);

                      Navigator.pop(context);
                    },
                    child: Text(t.saveButton),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------
  // LISTENER CHECKBOX (MERGED)
  // -------------------
  

  Future<void> _forceListenerOff() async {
  final repo = SettingsRepository();
  await repo.saveListenMode(false);
}


Widget _buildListenModeCheckbox() {
  final t = AppLocalizations.of(context)!;
  final usage = _listenerUsage;
  final repo = SettingsRepository();

  final listenerBlocked =
      !_isUpgraded && usage != null && usage.isLimitReached;

  return CheckboxListTile(
    title: Text(t.configListener),
    value: _listenEnabled,
    onChanged: (v) async {
      final wantsEnabled = v ?? false;

      // 🔴 BLOCK + DIALOG (THIS WAS MISSING)
      if (wantsEnabled && listenerBlocked) {
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(t.listenerLimitReachedTitle),
            content: Text(
              t.listenerLimitReachedBody(usage!.limit),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(t.later),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // upgrade flow later
                },
                child: Text(t.upgrade),
              ),
            ],
          ),
        );

        // 🔒 FORCE OFF
        await repo.saveListenMode(false);
        setState(() => _listenEnabled = false);
        return;
      }

      // ✅ NORMAL PATH
      await repo.saveListenMode(wantsEnabled);
      setState(() => _listenEnabled = wantsEnabled);

      if (wantsEnabled) {
        await _maybeShowListenerInversionNotice(t);
      }
    },
  );
}

  // --------------------------
  // EXISTING UI HELPERS
  // --------------------------

  Widget _buildTimerEnableCheckbox() {
    return CheckboxListTile(
      title: Text(AppLocalizations.of(context)!.configEnableTimer),
      value: _timerEnabled,
      onChanged: (v) => setState(() => _timerEnabled = v ?? false),
    );
  }

  Widget _buildTimerSlider(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: _timerSeconds.toDouble(),
          min: 1,
          max: 30,
          divisions: 29,
          label: _timerSeconds.toString(),
          onChanged: (value) {
            setState(() => _timerSeconds = value.round());
          },
        ),
        Text(
          _timerSeconds.toString(),
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _sectionTitle(String txt) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          txt,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );

  // --------------------------
  // LOCALIZATION HELPERS
  // --------------------------

  String _localizedChordType(String type, AppLocalizations t) {
    switch (type) {
      case "major":
        return t.chord_major;
      case "minor":
        return t.chord_minor;
      case "diminished":
        return t.chord_diminished;
      case "augmented":
        return t.chord_augmented;
      case "dominant7":
        return t.chord_dominant7;
      case "major7":
        return t.chord_major7;
      case "minor7":
        return t.chord_minor7;
      case "suspended2":
        return t.chord_suspended2;
      case "suspended4":
        return t.chord_suspended4;
      default:
        return type;
    }
  }

  String _localizedInversion(String inv, AppLocalizations t) {
    switch (inv) {
      case "root":
        return t.inv_root;
      case "first":
        return t.inv_first;
      case "second":
        return t.inv_second;
      default:
        return inv;
    }
  }
}

// --------------------------
// SNAPSHOT (UNCHANGED)
// --------------------------

class _ConfigSnapshot {
  final List<String> roots;
  final List<String> types;
  final List<String> inversions;
  final bool timerEnabled;
  final int timerSeconds;
  final bool listenEnabled;
  final String cardOrder;

  _ConfigSnapshot({
    required this.roots,
    required this.types,
    required this.inversions,
    required this.timerEnabled,
    required this.timerSeconds,
    required this.listenEnabled,
    required this.cardOrder,
  });

  factory _ConfigSnapshot.fromState(_ConfigScreenState s) {
    return _ConfigSnapshot(
      roots: [...s._selectedRoots]..sort(),
      types: [...s._selectedChordTypes]..sort(),
      inversions: [...s._selectedInversions]..sort(),
      timerEnabled: s._timerEnabled,
      timerSeconds: s._timerSeconds,
      listenEnabled: s._listenEnabled,
      cardOrder: s._cardOrder,
    );
  }

  bool equals(_ConfigSnapshot other) {
    return listEquals(roots, other.roots) &&
        listEquals(types, other.types) &&
        listEquals(inversions, other.inversions) &&
        timerEnabled == other.timerEnabled &&
        timerSeconds == other.timerSeconds &&
        listenEnabled == other.listenEnabled &&
        cardOrder == other.cardOrder;
  }
}
