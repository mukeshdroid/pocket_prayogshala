// import 'package:flame/components.dart';
// import 'dart:ui';
// import 'package:flame_shapes/flame_shapes.dart';

// class RectangleSprite extends ShapeComponent {
//   RectangleSprite({
//     required double width,
//     required double height,
//     required Color color,
//   }) {
//     shape = Shape.rectangle;
//     paint = Paint()..color = color;
//     size = Vector2(width, height);
//   }
// }

import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class MySprite extends SpriteComponent with HasGameRef {
  Color _color = const Color(0xFF00FF00);
  Offset _offset = const Offset(0.0, 0.8);
  double _duration = 0.5;

  @override
  void update(double dt) {
    if (colorEffect != null) {
      // update the color effect if it exists
      colorEffect.update(dt);
    }
  }

  void setOffset(Offset offset) {
    _offset = offset;
  }

  void setDuration(double duration) {
    _duration = duration;
  }

  ColorEffect get colorEffect => ColorEffect(
        _color,
        _offset,
        EffectController(duration: _duration),
      );
}
