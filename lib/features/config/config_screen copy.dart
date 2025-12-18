import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/data/settings_repository.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  // ------------------------------------------------------------
  // 1. ROOT NOTES
  // ------------------------------------------------------------
  final List<String> _roots = [
    "C", "Db", "D", "Eb", "E", "F",
    "Gb", "G", "Ab", "A", "Bb", "B",
  ];

  // ------------------------------------------------------------
  // 2. CHORD TYPES (internal keys)
  // ------------------------------------------------------------
final List<String> _chordTypeKeys = [
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

  // UI will show translated labels using t.*
  late Map<String, String> _localizedChordTypes;

  // ------------------------------------------------------------
  // 3. INVERSIONS
  // ------------------------------------------------------------
  final List<String> _inversionKeys = [
    "root",
    "first",
    "second",
  ];

  // ------------------------------------------------------------
  // Persistent values
  // ------------------------------------------------------------
  Set<String> _selectedRoots = {};
  Set<String> _selectedChordTypes = {};
  Set<String> _selectedInversions = {};

  bool _timerEnabled = false;
  int _timerSeconds = 5;

  bool _listenMode = false; // placeholder for future audio detection feature

  final SettingsRepository _repo = SettingsRepository();

  // ------------------------------------------------------------
  // INIT
  // ------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _loadSavedConfig();
  }

  Future<void> _loadSavedConfig() async {
    _selectedRoots = (await _repo.loadRoots()).toSet();
    _selectedChordTypes = (await _repo.loadChordTypes()).toSet();
    _selectedInversions = (await _repo.loadInversions()).toSet();

    final timer = await _repo.loadTimer();
    _timerEnabled = timer.$1;
    _timerSeconds = timer.$2;

    _listenMode = await _repo.loadListenMode();

    // If nothing saved yet, default select all
    if (_selectedRoots.isEmpty) {
      _selectedRoots = _roots.toSet();
    }
    if (_selectedChordTypes.isEmpty) {
      _selectedChordTypes = _chordTypeKeys.toSet();
    }
    if (_selectedInversions.isEmpty) {
      _selectedInversions = _inversionKeys.toSet();
    }

    setState(() {});
  }

  // ------------------------------------------------------------
  // HELPER: Prevent deselecting last option
  // ------------------------------------------------------------
  void _toggleWithGuard({
    required Set<String> set,
    required String value,
    required bool isChecked,
    required String message,
  }) {
    if (!isChecked) {
      if (set.length == 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
        return;
      }
      set.remove(value);
    } else {
      set.add(value);
    }
  }

  // ------------------------------------------------------------
  // SAVE ALL SETTINGS
  // ------------------------------------------------------------
  Future<void> _saveConfig() async {
    await _repo.saveRoots(_selectedRoots.toList());
    await _repo.saveChordTypes(_selectedChordTypes.toList());
    await _repo.saveInversions(_selectedInversions.toList());
    await _repo.saveTimer(_timerEnabled, _timerSeconds);
    await _repo.saveListenMode(_listenMode);

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    // Build translated labels for chord types
_localizedChordTypes = {
  "major": t.chord_major,
  "minor": t.chord_minor,
  "diminished": t.chord_diminished,
  "augmented": t.chord_augmented,
  "dominant7": t.chord_dominant7,
  "major7": t.chord_major7,
  "minor7": t.chord_minor7,
  "suspended2": t.chord_suspended2,
  "suspended4": t.chord_suspended4,
};


final inversionLabels = {
  "root": t.inv_root,
  "first": t.inv_first,
  "second": t.inv_second,
};


    return Scaffold(
      appBar: AppBar(title: Text(t.configTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------------------------------------
            // ROOT NOTES
            // ------------------------------------------------------------
            Text(t.configSelectRoots,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),

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
                          set: _selectedRoots,
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

            // ------------------------------------------------------------
            // CHORD TYPES
            // ------------------------------------------------------------
            Text(t.configSelectChordTypes,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),

            Wrap(
              children: _chordTypeKeys.map((key) {
                final label = _localizedChordTypes[key]!;
                final checked = _selectedChordTypes.contains(key);

                return SizedBox(
                  width: 200,
                  child: CheckboxListTile(
                    title: Text(label),
                    value: checked,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        _toggleWithGuard(
                          set: _selectedChordTypes,
                          value: key,
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

            // ------------------------------------------------------------
            // INVERSIONS
            // ------------------------------------------------------------
            Text(t.configSelectInversions,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),

Wrap(
  children: _inversionKeys.map((inv) {
    final checked = _selectedInversions.contains(inv);

    return SizedBox(
      width: 180,
      child: CheckboxListTile(
        title: Text(inversionLabels[inv]!),
        value: checked,
        onChanged: (v) {
          if (v == null) return;

          setState(() {
            _toggleWithGuard(
              set: _selectedInversions,
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

            // ------------------------------------------------------------
            // TIMER
            // ------------------------------------------------------------
            SwitchListTile(
              title: Text(t.configEnableTimer),
              value: _timerEnabled,
              onChanged: (v) => setState(() => _timerEnabled = v),
            ),
            if (_timerEnabled)
              Slider(
                value: _timerSeconds.toDouble(),
                min: 1,
                max: 15,
                divisions: 12,
                label: "$_timerSeconds s",
                onChanged: (v) => setState(() {
                  _timerSeconds = v.toInt();
                }),
              ),

            const SizedBox(height: 20),

            // ------------------------------------------------------------
            // LISTEN MODE (future feature)
            // ------------------------------------------------------------
            SwitchListTile(
              title: Text(t.configEnableListening),
              value: _listenMode,
              onChanged: (v) => setState(() => _listenMode = v),
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: _saveConfig,
                child: Text(t.saveButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
