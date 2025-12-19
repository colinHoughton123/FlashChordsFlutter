import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/data/settings_repository.dart';
import 'package:flashchords/core/system_error.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flashchords/l10n/app_localizations_extensions.dart';


class ConfigScreen extends ConsumerStatefulWidget {
  const ConfigScreen({super.key});

  @override
  ConsumerState<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends ConsumerState<ConfigScreen> {

    List<String> _sanitizeList(List<String> loaded, List<String> allowed) {
    // Keep only values that are actually in the allowed list
    final cleaned = loaded.where((v) => allowed.contains(v)).toList();

    // If everything was invalid / legacy, fall back to full set
    if (cleaned.isEmpty) {
      return [...allowed];
    }
    return cleaned;
  }

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

    // ----- ROOTS -----
    _selectedRoots = await repo.loadRoots();
    _selectedRoots = _sanitizeList(_selectedRoots, _roots);

    // ----- CHORD TYPES -----
    _selectedChordTypes = await repo.loadChordTypes();
    _selectedChordTypes = _sanitizeList(_selectedChordTypes, _chordTypes);

    // ----- INVERSIONS -----
    _selectedInversions = await repo.loadInversions();
    _selectedInversions = _sanitizeList(_selectedInversions, _inversions);

    // DEBUG to confirm we’re clean now
    print("SANITIZED inversions: $_selectedInversions");
    print("SANITIZED chordTypes: $_selectedChordTypes");
    print("SANITIZED roots: $_selectedRoots");

    // ----- TIMER -----
    final timer = await repo.loadTimer();
    _timerEnabled = timer.$1;
    _timerSeconds = timer.$2;

    // ----- LISTEN MODE -----
    _listenEnabled = await repo.loadListenMode();

    // ----- CARD ORDER -----
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
  SystemError.report(301, ref);
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
  backgroundColor: Colors.grey.shade100,
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
  // ------------new toggleguard ------
  void _toggleChipWithGuard({
    required List<String> list,
    required String value,
    required bool selected,   // this is the new state from FilterChip
    required AppLocalizations t,
  }) {
    final wasSelected = list.contains(value);
    final isTryingToUnselect = !selected;
    final isLastSelected = list.length == 1 && wasSelected;

    // DEBUG
    print(
        "TOGGLE GUARD → value=$value, selected=$selected, wasSelected=$wasSelected, len=${list.length}, isTryingToUnselect=$isTryingToUnselect, isLastSelected=$isLastSelected");

    if (isTryingToUnselect && isLastSelected) {
      // Trying to remove the final remaining item → block it

        SystemError.report(301, ref);
      return;
    }

    // Normal toggle behavior
    if (selected && !wasSelected) {
      list.add(value);
    } else if (!selected && wasSelected) {
      list.remove(value);
    }

    print("AFTER TOGGLE → list=$list");
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
           _toggleChipWithGuard(
                list: _selectedRoots,
                value: root,
                selected: checked,
                t: t,
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
           _toggleChipWithGuard(
                list: _selectedChordTypes,
                value: type,
                selected: checked,
                t: t,
              );
          });
        },
      );
    }).toList(),
  );
}

// --- SELECT INVERSIONS ---
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
              _toggleChipWithGuard(
                list: _selectedInversions,
                value: inv,
                selected: checked,
                t: t,
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