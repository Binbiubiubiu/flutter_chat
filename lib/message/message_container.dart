import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  final Widget child;

  /// The radii for each corner.
  final BorderRadiusGeometry borderRadius;

  final Color color;

  final MessageArrowDirect arrow;

  MessageContainer({
    Key key,
    this.child,
    this.color = Colors.white,
    this.arrow = MessageArrowDirect.left,
    this.borderRadius = const BorderRadius.all(Radius.circular(6.0)),
  })  : assert(borderRadius != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: _MessageBorder(
        borderRadius: borderRadius,
        color: color,
        arrow: arrow,
      ),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.56,
          ),
          child: child,
        ),
      ),
    );
  }
}

enum MessageArrowDirect {
  left,
  right,
}

class _MessageBorder extends ShapeBorder {
  /// Creates a rounded rectangle border.
  ///
  /// The arguments must not be null.
  const _MessageBorder({
    this.side = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.arrow,
  })  : assert(side != null),
        assert(borderRadius != null);

  /// The style of this border.
  final BorderSide side;

  final Color color;

  final MessageArrowDirect arrow;

  /// The radii for each corner.
  final BorderRadiusGeometry borderRadius;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }

  @override
  ShapeBorder scale(double t) {
    return _MessageBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder lerpFrom(ShapeBorder a, double t) {
    assert(t != null);
    if (a is _MessageBorder) {
      return _MessageBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t),
      );
    }

    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder lerpTo(ShapeBorder b, double t) {
    assert(t != null);
    if (b is _MessageBorder) {
      return _MessageBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t),
      );
    }

    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..addRRect(borderRadius
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final double width = side.width;
        if (width == 0.0) {
          canvas.drawRRect(
            borderRadius.resolve(textDirection).toRRect(rect),
            side.toPaint(),
          );
        } else {
          final RRect outer = borderRadius.resolve(textDirection).toRRect(rect);
          final RRect inner = outer.deflate(width);
          final Paint paint = Paint()..color = side.color;
          canvas.drawDRRect(outer, inner, paint);
        }
    }

    if (color != null) {
      drawArrow(canvas, rect);
    }
  }

  void drawArrow(Canvas canvas, Rect rect) {
    final Paint paint = Paint()..color = color;
    Path path = Path();
    double mid = 24;
    double s = 8;

    switch (arrow) {
      case MessageArrowDirect.left:
        path
          ..moveTo(-s, mid)
          ..lineTo(0, mid - s)
          ..lineTo(0, mid + s);
        break;
      case MessageArrowDirect.right:
        path
          ..moveTo(rect.width + s, mid)
          ..lineTo(rect.width, mid - s)
          ..lineTo(rect.width, mid + s);
        break;
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is _MessageBorder &&
        other.side == side &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => hashValues(side, borderRadius);

  @override
  String toString() {
    return '_MessageBorder($side, $borderRadius)';
  }
}
