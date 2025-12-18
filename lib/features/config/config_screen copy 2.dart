import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/data/settings_repository.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
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

  final List<String> _inversions = [
    "root",
    "first",
    "second",
  ];

  List<String> _selectedRoots = [];
  List<String> _selectedChordTypes = [];
  List<String> _selectedInversions = [];

  bool _timerEnabled = false;
  int _timerSeconds = 5;

  bool _listenEnabled = false;

  /// NEW: card order
  String _cardOrder = "random"; // or "sorted"

  @override
  void initState() {
    super.initState();
    _loadSavedConfig();
  }

  // --------------------------
  // LOAD SAVED STATE
  // --------------------------
  Future<void> _loadSavedConfig() async {
    final repo = SettingsRepository();

    _selectedRoots = await repo.loadRoots();
    if (_selectedRoots.isEmpty) {
      _selectedRoots = [..._roots];
    }

    _selectedChordTypes = await repo.loadChordTypes();
    if (_selectedChordTypes.isEmpty) {
      _selectedChordTypes = [..._chordTypes];
    }

    _selectedInversions = await repo.loadInversions();
    if (_selectedInversions.isEmpty) {
      _selectedInversions = [..._inversions];
    }

    final timer = await repo.loadTimer();
    _timerEnabled = timer.$1;
    _timerSeconds = timer.$2;

    _listenEnabled = await repo.loadListenMode();

    _cardOrder = await repo.loadCardOrder();

    setState(() {});
  }

  // --------------------------
  // GUARD LOGIC FOR CHECKBOXES
  // --------------------------
  void _toggleWithGuard({
    required List<String> list,
    required String value,
    required bool isChecked,
    required String message,
  }) {
    if (!isChecked && list.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      return;
    }

    if (isChecked) {
      list.add(value);
    } else {
      list.remove(value);
    }
  }

  // --------------------------
  // BUILD UI
  // --------------------------
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.configTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ---------------------------
          // ROOT NOTES
          // ---------------------------
          Text(t.configSelectRoots, style: const TextStyle(fontSize: 18)),
          Wrap(
            children: _roots.map((r) {
              final checked = _selectedRoots.contains(r);
              return SizedBox(
                width: 130,
                child: CheckboxListTile(
                  title: Text(r),
                  value: checked,
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      _toggleWithGuard(
                        list: _selectedRoots,
                        value: r,
                        isChecked: v,
                        message: t.configAtLeastOneOption,
                      );
                    });
                  },
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // ---------------------------
          // CHORD TYPES
          // ---------------------------
          Text(t.configSelectChordTypes, style: const TextStyle(fontSize: 18)),
          Wrap(
            children: _chordTypes.map((type) {
              final checked = _selectedChordTypes.contains(type);
              final label = _localizedChordType(type, t);

              return SizedBox(
                width: 180,
                child: CheckboxListTile(
                  title: Text(label),
                  value: checked,
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      _toggleWithGuard(
                        list: _selectedChordTypes,
                        value: type,
                        isChecked: v,
                        message: t.configAtLeastOneOption,
                      );
                    });
                  },
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // ---------------------------
          // INVERSIONS
          // ---------------------------
          Text(t.configSelectInversions, style: const TextStyle(fontSize: 18)),
          Wrap(
            children: _inversions.map((inv) {
              final checked = _selectedInversions.contains(inv);
              final label = _localizedInversion(inv, t);

              return SizedBox(
                width: 180,
                child: CheckboxListTile(
                  title: Text(label),
                  value: checked,
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      _toggleWithGuard(
                        list: _selectedInversions,
                        value: inv,
                        isChecked: v,
                        message: t.configAtLeastOneOption,
                      );
                    });
                  },
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // ---------------------------
          // CARD ORDER (Radio buttons)
          // ---------------------------
          Text(t.configCardOrder, style: const TextStyle(fontSize: 18)),
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

          const SizedBox(height: 20),

          // ---------------------------
          // TIMER
          // ---------------------------
          SwitchListTile(
            title: Text(t.configEnableTimer),
            value: _timerEnabled,
            onChanged: (v) => setState(() => _timerEnabled = v),
          ),

          if (_timerEnabled)
            Row(
              children: [
                Text(t.configTimerSeconds),
                const SizedBox(width: 10),
                Expanded(
                  child: Slider(
                    min: 1,
                    max: 15,
                    divisions: 14,
                    value: _timerSeconds.toDouble(),
                    label: "$_timerSeconds",
                    onChanged: (v) =>
                        setState(() => _timerSeconds = v.toInt()),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 20),

          // ---------------------------
          // LISTEN MODE (future)
          // ---------------------------
          SwitchListTile(
            title: Text(t.configEnableListening),
            subtitle: Text(t.configEnableListeningDesc),
            value: _listenEnabled,
            onChanged: (v) => setState(() => _listenEnabled = v),
          ),

          const SizedBox(height: 30),

          // ---------------------------
          // SAVE BUTTON
          // ---------------------------
          ElevatedButton(
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
        ],
      ),
    );
  }

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