import 'package:flutter/material.dart';

import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/features/config/config_screen.dart';
import 'package:flashchords/features/flashcard/flashcard_screen.dart';
import 'package:flashchords/models/flashcard_item.dart';
import 'package:flashchords/data/chord_xml_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ✅ dialog is in features/welcome
import 'package:flashchords/features/welcome/language_picker_dialog.dart';

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
    _loadChords();
  }

  Future<void> _loadChords() async {
    setState(() => _loadingChords = true);
    try {
      _preloadedItems = await loadFlashcardsFromXml();
    } finally {
      if (mounted) setState(() => _loadingChords = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
debugPrint(
  '🏠 Welcome build: loading=$_loadingChords items=${_preloadedItems?.length}',
);
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
                  Text(
                    'FlashChords',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Text(
                    t.flash_welcome1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    t.flash_welcome2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),

                  Text(
                    t.flash_swipe_right,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    t.flash_swipe_left,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    t.flash_not_sure,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),

                  if (_preloadedItems == null)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 12),
                        Text(t.loadingChords),
                      ],
                    )
                  else ...[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => FlashcardScreen(
                              items: _preloadedItems!,
                              userPressedStart: true,
                            ),
                          ),
                        );
                      },
                      child: Text(t.start),
                    ),
                    const SizedBox(height: 12),

                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ConfigScreen(),
                          ),
                        );
                      },
                      child: Text(t.configure), // ✅ .arb key
                    ),
                  ],
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