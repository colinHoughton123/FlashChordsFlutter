import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/models/inversion_type.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter/services.dart';




class FlashcardWidget extends StatefulWidget {
  
  final String chordLabel;              // e.g. "C Major"
  final String cardTitle;
  final InversionType inversion;        // root / first / second
  final List<String> imageAssetPaths;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onFrontShown;
final VoidCallback? onBackShown;
  final VoidCallback? onRevealRequested;


  final String cardId;                  // <-- NEW: unique ID per card

  const FlashcardWidget({
    super.key,
    required this.chordLabel,
    required this.cardTitle,  // NEW
    required this.inversion,
    required this.imageAssetPaths,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.cardId,
        this.onFrontShown,
    this.onBackShown,
    this.onRevealRequested,
  });

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

// late Animation<Offset> _slideAnimation;
// Offset _dragOffset = Offset.zero;
bool _hasEverAnimated = false;

late final String _debugInstanceId =
    '${widget.cardId} @ ${identityHashCode(this)}';


bool _suppressFlipForNextBuild = false;



@override
void didUpdateWidget(covariant FlashcardWidget oldWidget) {
  super.didUpdateWidget(oldWidget);
debugPrint(
    '🔁 UPDATE $_debugInstanceId '
    'oldCard=${oldWidget.cardId} '
    'newCard=${widget.cardId} '
    'showBack=$_showBack'
  );
  if (oldWidget.cardId != widget.cardId) {
    // New card → hard reset visual state
    setState(() {
      _showBack = false;
      _dragOffset = Offset.zero;
      _rotation = 0;
    });

    _controller.reset();

    widget.onFrontShown?.call();
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
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotationAnimation;




  // ---------------------------------------------------------------------------
  // init / dispose
  // ---------------------------------------------------------------------------
@override
void initState() {
  super.initState();
debugPrint('🟢 INIT  $_debugInstanceId');
 _dbg = '${widget.cardId} @ ${identityHashCode(this)}';
  _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );
// 🔥 CRITICAL: identity slide on first frame
  _slideAnimation = const AlwaysStoppedAnimation(Offset.zero);

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
void _animateOut(bool toRight) {
  _hasEverAnimated = true;

  // ✅ Force front before swipe animation
  if (_showBack) {
    setState(() {
      _showBack = false;
    });
  }

  final endOffset = Offset(toRight ? 1.2 : -1.2, 0);
  final endRotation = toRight ? 0.25 : -0.25;

  _slideAnimation = Tween(
    begin: Offset.zero,
    end: endOffset,
  ).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeOut),
  );

  _rotationAnimation = Tween(
    begin: 0.0,
    end: endRotation,
  ).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeOut),
  );

  _controller.forward().whenComplete(() {
    if (!mounted) return;

    // Reset visual state AFTER animation completes
    setState(() {
      _dragOffset = Offset.zero;
      _rotation = 0;
      _showBack = false;
    });

    _controller.reset();

    // Advance deck
    if (toRight) {
      widget.onSwipeRight();
    } else {
      widget.onSwipeLeft();
    }
  });
}

void forceShowFront() {
  debugPrint('🔄 FORCE FRONT $_debugInstanceId');
  setState(() {
    _showBack = false;
  });
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

        onPanEnd: (_) {
          final threshold = MediaQuery.of(context).size.width * 0.25;

if (_dragOffset.dx > threshold){
            _animateOut(true);
          } else if (_dragOffset.dx < -threshold) {
            _animateOut(false);
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
          final offset = (!_hasEverAnimated || !_controller.isAnimating)
              ? Offset.zero
              : _slideAnimation.value;

          final rot = (!_hasEverAnimated || !_controller.isAnimating)
              ? 0.0
              : _rotationAnimation.value;
          final screenWidth = MediaQuery.of(context).size.width;

          return FractionalTranslation(
            translation: offset,
            child: Transform.rotate(
              angle: rot,
              child: child!,
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
   // final bool macSafe =
   //     !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

    final bool macSafe = false;
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
            child: macSafe ? _buildMacSafeFlip() : _buildAnimatedFlip(),
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
        IconButton(
          iconSize: 40,
          color: Colors.red,
          icon: const Icon(Icons.close),
          onPressed: () => _animateOut(false),
        ),
        IconButton(
          iconSize: 40,
          color: Colors.green,
          icon: const Icon(Icons.check),
          onPressed: () => _animateOut(true),
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
  return AnimatedSwitcher(
    duration: _suppressFlipForNextBuild
        ? Duration.zero
        : const Duration(milliseconds: 250),

    switchInCurve: Curves.easeInOut,
    switchOutCurve: Curves.easeInOut,

    // ✅ This is the key: when suppressed, do NOT render outgoing child at all
    layoutBuilder: (currentChild, previousChildren) {

        debugPrint(
    '🧩 LAYOUT $_dbg '
    'suppress=$_suppressFlipForNextBuild '
    'prev=${previousChildren.length}'
  );


      if (_suppressFlipForNextBuild) {
        return currentChild ?? const SizedBox.shrink();
      }
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      );
    },

    transitionBuilder: (child, anim) {
      if (_suppressFlipForNextBuild) return child;

      final rotate = Tween<double>(begin: pi / 2, end: 0.0).animate(anim);

      return AnimatedBuilder(
        animation: rotate,
        builder: (_, __) {
          final key = child.key;
          final isBack = key is ValueKey && key.value == 'back';
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
  );
}


  // -----------------------------------------------------------------------------
  // FRONT & BACK CONTENT
  // -----------------------------------------------------------------------------

Widget _buildFront({Key? key}) {
  final t = AppLocalizations.of(context)!;

  return Container(
    key: key,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       

          // New line: localized chord name
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


        // 1st line: writtenAs exactly from XML
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

        // 2nd line: localized inversion
        Text(
          _localizedInversion(t),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget _buildBack({Key? key}) {
  if (!_showBack) {
    return const SizedBox.shrink();
  }

  return Container(
    key: key,
    child: ListView(
      children: widget.imageAssetPaths.map((path) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Image.asset(
            path,
            height: 110,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.image_not_supported, size: 60),
          ),
        );
      }).toList(growable: false),
    ),
  );
}
}