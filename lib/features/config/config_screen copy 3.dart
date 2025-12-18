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
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ----- Select Chords -----
            _sectionTitle(t.configSelectRoots),
            _buildNoteSelectors(),
            const SizedBox(height: 22),

            // ----- Select Chord Types -----
            _sectionTitle(t.configSelectChordTypes),
            _buildChordTypeSelectors(),
            const SizedBox(height: 22),

            // ----- Select Inversions -----
            _sectionTitle(t.configSelectInversions),
            _buildInversionSelectors(),
            const SizedBox(height: 22),

            const Divider(height: 36),



_sectionTitle(t.configCardOrder),

RadioListTile<String>(
  title: Text(t.configCardOrderRandom),
  value: "random",
  groupValue: _cardOrder,
  onChanged: (value) {
    setState(() {
      _cardOrder = value!;
    });
  },
),

RadioListTile<String>(
  title: Text(t.configCardOrderSorted),
  value: "sorted",
  groupValue: _cardOrder,
  onChanged: (value) {
    setState(() {
      _cardOrder = value!;
    });
  },
),


                        const Divider(height: 36),

            _buildTimerEnableCheckbox(),

if (_timerEnabled)
  _buildTimerSlider(t.configTimerSeconds),

Divider(),

_buildListenModeCheckbox(),

            // ----- Timer -----
         
            //_buildTimerEnableCheckbox(),


            const Divider(height: 36),

            const SizedBox(height: 30),

            // SAVE BUTTON
          
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () async {
      final repo = SettingsRepository();

      await repo.saveRoots(_selectedRoots);
      await repo.saveChordTypes(_selectedChordTypes);
      await repo.saveInversions(_selectedInversions);
      await repo.saveTimer(_timerEnabled, _timerSeconds);
      await repo.saveListenMode(_listenEnabled);   // exists already
      await repo.saveCardOrder(_cardOrder);

      Navigator.pop(context);
    },
    child: Text(t.saveButton),
  ),
),
            const SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

// ---------- Shared title widget ----------
Widget _sectionTitle(String txt) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 8),
  child: Text(
    txt,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
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

  // --- SELECT ROOTS ---
Widget _buildNoteSelectors() {
  final t = AppLocalizations.of(context)!;   //<-- ADD THIS
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: _roots.map((root) {
      return FilterChip(
        label: Text(root),
        selected: _selectedRoots.contains(root),
                onSelected: (checked) {
          setState(() {
            _toggleWithGuard(
              list: _selectedRoots,
              value:root,
              isChecked: checked,
              message: t.configAtLeastOneOption,
            );
          });
        },
      );
    }).toList(),
  );
}

// --- SELECT CHORD TYPES ---
Widget _buildChordTypeSelectors() {
  final t = AppLocalizations.of(context)!;

  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: _chordTypes.map((type) {
      return FilterChip(
        label: Text(_localizedChordType(type, t)),
        selected: _selectedChordTypes.contains(type),
                onSelected: (checked) {
          setState(() {
            _toggleWithGuard(
              list: _selectedChordTypes,
              value: type,
              isChecked: checked,
              message: t.configAtLeastOneOption,
            );
          });
        },
      );
    }).toList(),
  );
}

// --- SELECT INVERSIONS ---
Widget _buildInversionSelectors() {
  final t = AppLocalizations.of(context)!;

  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: _inversions.map((inv) {
      return FilterChip(
        label: Text(_localizedInversion(inv, t)),
        selected: _selectedInversions.contains(inv),
                onSelected: (checked) {
          setState(() {
            _toggleWithGuard(
              list: _selectedInversions,
              value: inv,
              isChecked: checked,
              message: t.configAtLeastOneOption,
            );
          });
        },
      );
    }).toList(),
  );
}

Widget _buildTimerEnableCheckbox() {
  return CheckboxListTile(
    title: Text(AppLocalizations.of(context)!.configEnableTimer),
    value: _timerEnabled,
    onChanged: (v) {
      setState(() => _timerEnabled = v ?? false);
    },
  );
}

Widget _buildListenModeCheckbox() {
  return CheckboxListTile(
    title: const Text("Enable Listening Mode (Future Feature)"),
    value: _listenEnabled,
    onChanged: (v) {
      setState(() => _listenEnabled = v ?? false);
    },
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


}