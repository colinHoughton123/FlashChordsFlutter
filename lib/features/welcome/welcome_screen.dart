import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/features/config/config_screen.dart';
import 'package:flashchords/features/flashcard/flashcard_screen.dart';
import 'package:flashchords/models/flashcard_item.dart';
import 'package:flashchords/data/chord_xml_parser.dart'; 







class WelcomeScreen extends StatefulWidget {
  final void Function(List<FlashcardItem>) onStart;
  final Future<void> Function(String) onLanguageChanged;

  const WelcomeScreen({
    super.key,
    required this.onStart,
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
          WidgetsBinding.instance.addPostFrameCallback((_) async {
           
          });
        }

      Future<void> _loadChords() async {
        setState(() => _loadingChords = true);

        // 👇 Give Flutter one frame to paint the loading UI
        //await Future<void>.delayed(Duration.zero);

        try {

          // 👇 FORCE UI TO SHOW LOADING
            // await Future.delayed(const Duration(milliseconds: 600));  // use this to force visibliting of Loading Chords...

          _preloadedItems = await loadFlashcardsFromXml();

        } finally {
          setState(() => _loadingChords = false);
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
    actions: [
      IconButton(
        icon: const Icon(Icons.settings),
        color: Colors.teal,
        iconSize: 30,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ConfigScreen()),
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
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    t.flash_swipe_left,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    t.flash_not_sure,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (_loadingChords)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 12),
                        Text(t.loadingChords),
                      ],
                    )
                  else
                    ElevatedButton(
                      onPressed: () async {
                        if (_preloadedItems == null) return;
                        debugPrint('WELCOME SCREEN: START PRESSED');
                        // await _loadChords();
                        widget.onStart(_preloadedItems!);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: Text(t.start),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  value: Localizations.localeOf(context).languageCode,
                  underline: const SizedBox.shrink(),
                  items: const [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: 'es',
                      child: Text('Español'),
                    ),
                  ],
                  onChanged: (code) {
                    if (code != null) {
                      widget.onLanguageChanged(code);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);
  }
}