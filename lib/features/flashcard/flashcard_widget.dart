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


@override
void didUpdateWidget(covariant FlashcardWidget oldWidget) {
  super.didUpdateWidget(oldWidget);


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

  _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );


}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  // ---------------------------------------------------------------------------
  // Flip to back (used by timer)
  // ---------------------------------------------------------------------------
void flipToBack() {
  setState(() {
    _showBack = true;
  });
  widget.onBackShown?.call();
}

  // ---------------------------------------------------------------------------
  // ANIMATION (swipe off screen)
  // ---------------------------------------------------------------------------
void _animateOut(bool toRight) {
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
            final offset = _controller.isAnimating
                ? _slideAnimation.value
                : _dragOffset;

            final rot = _controller.isAnimating
                ? _rotationAnimation.value
                : _rotation;

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
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------------
  // CARD SURFACE
  // -----------------------------------------------------------------------------

  Widget _buildCard() {
    final bool macSafe =
        !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

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
      duration: const Duration(milliseconds: 250),
      child:
          _showBack ? _buildBack(key: const ValueKey("back")) : _buildFront(key: const ValueKey("front")),
      transitionBuilder: (child, anim) {
        final rotate = Tween(begin: pi / 2, end: 0.0).animate(anim);

        return AnimatedBuilder(
          animation: rotate,
          builder: (_, __) {
            final isBack = child.key == const ValueKey("back");
            final angle = isBack ? -rotate.value : rotate.value;

            return Transform(
              transform: Matrix4.rotationY(angle),
              alignment: Alignment.center,
              child: child,
            );
          },
        );
      },
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