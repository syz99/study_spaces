import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

/// Partially overlays and then blurs its child's background.
class FrostedBox extends StatelessWidget {
  const FrostedBox({
    this.child,
    Key key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xccf8f8f8),
        ),
        child: child,
      ),
    );
  }
}

/// An Icon that implicitly animates changes to its color.
class ColorChangingIcon extends ImplicitlyAnimatedWidget {
  const ColorChangingIcon(
      this.icon, {
        this.color = CupertinoColors.black,
        this.size,
        @required Duration duration,
        Key key,
      })  : assert(icon != null),
        assert(color != null),
        assert(duration != null),
        super(key: key, duration: duration);

  final Color color;

  final IconData icon;

  final double size;

  @override
  _ColorChangingIconState createState() => _ColorChangingIconState();
}

class _ColorChangingIconState
    extends AnimatedWidgetBaseState<ColorChangingIcon> {
  ColorTween _colorTween;

  @override
  Widget build(BuildContext context) {
    return Icon(
      widget.icon,
      semanticLabel: 'Close button',
      size: widget.size,
      color: _colorTween?.evaluate(animation),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _colorTween = visitor(
      _colorTween,
      widget.color,
          (dynamic value) => ColorTween(begin: value as Color),
    ) as ColorTween;
  }
}

/// A simple "close this modal" button that invokes a callback when pressed.
class CloseButton extends StatefulWidget {
  const CloseButton(this.onPressed);

  final VoidCallback onPressed;

  @override
  CloseButtonState createState() {
    return CloseButtonState();
  }
}

class CloseButtonState extends State<CloseButton> {
  bool tapInProgress = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() => tapInProgress = true);
      },
      onTapUp: (details) {
        setState(() => tapInProgress = false);
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() => tapInProgress = false);
      },
      child: ClipOval(
        child: FrostedBox(
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: ColorChangingIcon(
                CupertinoIcons.clear_thick,
                duration: Duration(milliseconds: 300),
                color: tapInProgress
                    ? Color(0xff808080)
                    : Color(0xff101010),
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}