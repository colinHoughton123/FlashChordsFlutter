import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/models/inversion_type.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter/services.dart';

import 'package:flashchords/models/flashcard_item.dart';




class FlashcardWidget extends StatefulWidget {
  final String chordLabel;
  final String cardTitle;
  final InversionType inversion;
  final List<String> imageAssetPaths;
  final Set<String> noteSet;
  final bool showBack;

  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onFrontShown;
  final VoidCallback? onBackShown;
  final VoidCallback? onRevealRequested;
  final VoidCallback? onSwipeAnimationStarted;

  final String cardId;

  const FlashcardWidget({
    Key? key,
    required this.chordLabel,
    required this.cardTitle,
    required this.inversion,
    required this.imageAssetPaths,
    required this.noteSet,
    required this.showBack,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.cardId,
    this.onFrontShown,
    this.onBackShown,
    this.onRevealRequested,
    this.onSwipeAnimationStarted,
  }) : super(key: key);

  @override
  FlashcardWidgetState createState() => FlashcardWidgetState();
}
/// -----------------------------------------------------------------------------
///  The **public** state class, required because FlashcardScreen owns a
///  GlobalKey<FlashcardWidgetState>
/// -----------------------------------------------------------------------------
class FlashcardWidgetState extends State<FlashcardWidget>
    with SingleTickerProviderStateMixin {

late final String _dbg;



bool _frontShownOnce = false;
bool _isAnimatingOut = false;
bool _blankWhileAnimatingOut = false;

// late Animation<Offset> _slideAnimation;
// Offset _dragOffset = Offset.zero;
bool _hasEverAnimated = false;

late final String _debugInstanceId =
    '${widget.cardId} @ ${identityHashCode(this)}';


bool _suppressFlipForNextBuild = false;

void animateCorrect() {
 // _animateOut(true);
}

void animateIncorrect() {
 //  _animateOut(false);
}


List<String> _notesForInversion(
  Set<String> rootOrderedNotes,
  InversionType inversion,
) {
  final notes = rootOrderedNotes.toList(growable: false);

  if (notes.isEmpty) return notes;

  switch (inversion) {
    case InversionType.root:
      return notes;

    case InversionType.first:
      return [
        ...notes.sublist(1),
        notes.first,
      ];

    case InversionType.second:
      return [
        ...notes.sublist(2),
        ...notes.sublist(0, 2),
      ];
  }
}




@override
void didUpdateWidget(covariant FlashcardWidget oldWidget) {
  super.didUpdateWidget(oldWidget);

  debugPrint(
    '🔁 UPDATE $_debugInstanceId '
    'oldCard=${oldWidget.cardId} '
    'newCard=${widget.cardId} '
    'oldShowBack=${oldWidget.showBack} '
    'newShowBack=${widget.showBack}'
  );

  // --------------------------------------------------
  // 1️⃣ NEW CARD → hard reset visual state
  // --------------------------------------------------
  if (oldWidget.cardId != widget.cardId) {
    debugPrint('🧹 RESET visual state for new card ${widget.cardId}');

    setState(() {
      _frontShownOnce = false;
      _showBack = false;              // ✅ start on FRONT
      _dragOffset = Offset.zero;
      _rotation = 0;
      _blankWhileAnimatingOut = false;
    });

    _controller.reset();
    return;
  }

  // --------------------------------------------------
  // 2️⃣ REVEAL requested by parent (timer or listener)
  // --------------------------------------------------
  if (!oldWidget.showBack && widget.showBack) {
    debugPrint('🔄 revealBack via parent state');

    setState(() {
      _showBack = true;
    });
  }
}

bool _firstBuild = true;



  // ---------------------------------------------------------------------------
  //  LOCALIZED INVERSION LABEL
  // ---------------------------------------------------------------------------
  String _localizedInversion(AppLocalizations t) {
    switch (widget.inversion) {
      case InversionType.root:
        return t.inv_root;
      case InversionType.first:
        return t.inv_first;
      case InversionType.second:
        return t.inv_second;
    }
  }

  // ---------------------------------------------------------------------------
  //  STATE
  // ---------------------------------------------------------------------------
  bool _showBack = false;
  Offset _dragOffset = Offset.zero;
  double _rotation = 0;

  late AnimationController _controller;

//  late Animation<Offset> _slideAnimation;
  late Animation<double> _slideX; 
  late Animation<double> _rotationAnimation;




  // ---------------------------------------------------------------------------
  // init / dispose
  // ---------------------------------------------------------------------------
@override
void initState() {
  super.initState();


// 🔑 Fire once for the very first card render
//  WidgetsBinding.instance.addPostFrameCallback((_) {
//    widget.onFrontShown?.call();
//   });

  debugPrint('🟢 INIT  $_debugInstanceId');
  _dbg = '${widget.cardId} @ ${identityHashCode(this)}';

  _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );

  // ✅ Safe defaults so AnimatedBuilder can always read .value
 // _slideAnimation = const AlwaysStoppedAnimation<Offset>(Offset.zero);
  _slideX = const AlwaysStoppedAnimation(0.0);
  _rotationAnimation = const AlwaysStoppedAnimation<double>(0.0);
}

@override
void dispose() {
  debugPrint('🔴 DISPOSE $_debugInstanceId');
  _controller.dispose();
  super.dispose();
}

  // ---------------------------------------------------------------------------
  // Flip to back (used by timer)
  // ---------------------------------------------------------------------------
  void flipToBack() {
   debugPrint('🔄 FLIP → BACK $_debugInstanceId');
  setState(() {
    _showBack = true;
  });
  widget.onBackShown?.call();
}

  // ---------------------------------------------------------------------------
  // ANIMATION (swipe off screen)
  // ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ANIMATION (swipe off screen)
// ---------------------------------------------------------------------------
Future<void> animateOut({required bool toRight}) async {
  if (!mounted) return;

  debugPrint('➡️ animateOut(toRight=$toRight)');

  final screenWidth = MediaQuery.of(context).size.width;
  final travel = screenWidth + 100;

  _slideX = Tween<double>(
    begin: 0.0,
    end: toRight ? travel : -travel,
  ).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeOut),
  );

  _rotationAnimation = Tween<double>(
    begin: 0.0,
    end: toRight ? 0.25 : -0.25,
  ).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeOut),
  );

  // Prevent any ghosting while animating out
  setState(() {
    // _blankWhileAnimatingOut = true;
  });

  await _controller.forward(from: 0.0);

  debugPrint('🎬 ANIMATION COMPLETE for ${widget.cardId} (mounted=$mounted)');
  if (!mounted) return;

  // IMPORTANT:
  // Do NOT trigger navigation here.
  // Parent (FlashcardScreen) already awaited this Future.

  // Reset local visual state quietly
  _controller.reset();
  _dragOffset = Offset.zero;
  _rotation = 0;
  _showBack = false;
  _blankWhileAnimatingOut = false;
}

void forceShowFront() {
  debugPrint('🔄 FORCE FRONT $_debugInstanceId');
  setState(() {
    _showBack = false;
  });

  debugPrint('🟢 about to call widget.onFrontShown?.call() from forceShowFront');

  widget.onFrontShown?.call();
}
  // -----------------------------------------------------------------------------
  // BUILD
  // -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {


    return Center(

      // Force front for new card builds


      child: GestureDetector(
         behavior: HitTestBehavior.opaque,
        onTap: () {
        if (!_showBack) {
          widget.onRevealRequested?.call();
        }
  },

        onPanUpdate: (details) {
          setState(() {
            _dragOffset += details.delta;
            _rotation = _dragOffset.dx / 300;
          });
        },

       onPanEnd: (_) async {
            final threshold = 120.0;

            if (_dragOffset.dx > threshold) {
              await animateOut(toRight: true);
              widget.onSwipeRight(); // ✅ correct // ✅ parent advances deck AFTER animation
            } else if (_dragOffset.dx < -threshold) {
              await animateOut(toRight: false);
              widget.onSwipeLeft();
            } else {
              setState(() {
                _dragOffset = Offset.zero;
                _rotation = 0;
              });
            }
          },

        child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          // ✅ FIRST CARD: absolutely no translation
         final inFlight = _controller.value > 0.0;

//final offset = inFlight ? _slideAnimation.value : _dragOffset;
final dx = inFlight ? _slideX.value : _dragOffset.dx;
final dy = _dragOffset.dy;

final rot = inFlight ? _rotationAnimation.value : _rotation;
          final screenWidth = MediaQuery.of(context).size.width;

          return Transform.translate(
  offset: Offset(
    _controller.value > 0 ? _slideX.value : _dragOffset.dx,
    _dragOffset.dy,
  ),
  child: Transform.rotate(
    angle: _controller.value > 0 ? _rotationAnimation.value : _rotation,
    child: child,
  ),
);
        },
        child: _buildCard(),
      )
      ),
    );
  }

  // -----------------------------------------------------------------------------
  // CARD SURFACE
  // -----------------------------------------------------------------------------
Widget _buildCard() {
  final bool macSafe = false; // as you currently have

  return Container(
    width: 330,
    height: 480,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          blurRadius: 12,
          offset: Offset(0, 6),
          color: Colors.black26,
        )
      ],
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        Expanded(
          child: _blankWhileAnimatingOut
              ? const SizedBox.expand() // ✅ blank only the CONTENTS
              : (macSafe ? _buildMacSafeFlip() : _buildAnimatedFlip()),
        ),
        const SizedBox(height: 12),
        _buildButtons(),
      ],
    ),
  );
}
  
  // -----------------------------------------------------------------------------
  // BUTTON ROW
  // -----------------------------------------------------------------------------

Widget _buildButtons() {
return Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // ❌ Incorrect
    IconButton(
      iconSize: 40,
      color: Colors.red,
      icon: const Icon(Icons.close),
      onPressed: () async {
        await animateOut(toRight: false);
        widget.onSwipeLeft();
      },
    ),

     
    // ⚡ Reveal — FRONT ONLY
    if (!widget.showBack)
      Tooltip(
        message: AppLocalizations.of(context)!.flash_reveal,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            widget.onRevealRequested?.call();
          },
          child: Padding(
            padding: const EdgeInsets.all(8), // good hit target
            child: Image.asset(
              'assets/icons/flashchords_reveal.png',
              width: 40,
              height: 40,
            ),
          ),
        ),
      )
    else
      const SizedBox(width: 40), // keeps spacing stable


    // ✅ Correct
    IconButton(
      iconSize: 40,
      color: Colors.green,
      icon: const Icon(Icons.check),
      onPressed: () async {
        await animateOut(toRight: true);
        widget.onSwipeRight();
      },
    ),
  ],
);
}

  // -----------------------------------------------------------------------------
  // FLIP BACK & FRONT
  // -----------------------------------------------------------------------------

  Widget _buildMacSafeFlip() {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: _showBack ? 0 : 1,
          duration: const Duration(milliseconds: 200),
          child: _buildFront(),
        ),
        AnimatedOpacity(
          opacity: _showBack ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: _buildBack(),
        ),
      ],
    );
  }

Widget _buildAnimatedFlip() {
  return KeyedSubtree(
    key: ValueKey(widget.cardId), // 🔥 resets flip state per card
    child: AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,

      transitionBuilder: (child, anim) {
        final rotate = Tween<double>(
          begin: pi / 2,
          end: 0.0,
        ).animate(anim);

        return AnimatedBuilder(
          animation: rotate,
          builder: (_, __) {
            final isBack =
                child.key is ValueKey && (child.key as ValueKey).value == 'back';

            final angle = isBack ? -rotate.value : rotate.value;

            return Transform(
              transform: Matrix4.rotationY(angle),
              alignment: Alignment.center,
              child: child,
            );
          },
        );
      },

      child: KeyedSubtree(
        key: ValueKey(_showBack ? 'back' : 'front'),
        child: _showBack ? _buildBack() : _buildFront(),
      ),
    ),
  );
}

  // -----------------------------------------------------------------------------
  // FRONT & BACK CONTENT
  // -----------------------------------------------------------------------------

Widget _buildFront({Key? key}) {
  final t = AppLocalizations.of(context)!;

  return Builder(
    builder: (context) {
      // 🔑 This runs AFTER the front face is actually rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_frontShownOnce) {
          _frontShownOnce = true;
          widget.onFrontShown?.call();
        }
      });

      return Container(
        key: key,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Localized chord name
            Html(
              data: widget.cardTitle,
              style: {
                "*": Style(
                  fontSize: FontSize(24),
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              },
            ),

            // Written-as (XML exact)
            Html(
              data: widget.chordLabel,
              style: {
                "*": Style(
                  fontSize: FontSize(14),
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              },
            ),

            const SizedBox(height: 8),

            // Localized inversion
            Text(
              _localizedInversion(t),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildBack({Key? key}) {
  if (!_showBack) {
    return const SizedBox.shrink();
  }

  final orderedNotes = _notesForInversion(
    widget.noteSet,
    widget.inversion,
  );

  return Container(
    key: key,
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    child: Column(
      children: [
        // ─────────────────────────────
        // TITLE (same as front)
        // ─────────────────────────────
        Html(
          data: widget.cardTitle,
          style: {
            "*": Style(
              fontSize: FontSize(30),
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          },
        ),

        Html(
          data: widget.chordLabel,
          style: {
            "*": Style(
              fontSize: FontSize(14),
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          },
        ),

        const SizedBox(height: 14),

        // ─────────────────────────────
        // PIANO GRAPHIC (placeholder)
        // ─────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Image.asset(
            widget.imageAssetPaths.first,
            fit: BoxFit.contain,
            width: double.infinity,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.image_not_supported, size: 60),
          ),
        ),

        const SizedBox(height: 14),

        // ─────────────────────────────
        // NOTE NAMES (in inversion order)
        // ─────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: orderedNotes.map((note) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                note,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(growable: false),
        ),
      ],
    ),
  );
}
}