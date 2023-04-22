import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

final _regularTextStyle =
    TextStyle(fontSize: 18, color: BasicPalette.white.color);
final _regular = TextPaint(style: _regularTextStyle);
final _tiny = TextPaint(style: _regularTextStyle.copyWith(fontSize: 14.0));
final _box = _regular.copyWith(
  (style) => style.copyWith(
    color: Colors.lightGreenAccent,
    fontFamily: 'monospace',
    letterSpacing: 2.0,
  ),
);
final _shaded = TextPaint(
  style: TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 40.0,
    shadows: const [
      Shadow(
          color: Color.fromARGB(255, 244, 250, 65),
          offset: Offset(2, 2),
          blurRadius: 2),
      Shadow(
          color: Color.fromARGB(255, 45, 6, 145),
          offset: Offset(4, 4),
          blurRadius: 4),
    ],
  ),
);

class MyTextBox extends TextBoxComponent {
  MyTextBox(
    String text, {
    super.align,
    super.size,
    double? timePerChar,
    double? margins,
  }) : super(
          text: text,
          textRenderer: _shaded,
          boxConfig: TextBoxConfig(
            maxWidth: 400,
            timePerChar: timePerChar ?? 0.00,
            growingBox: true,
            margins: EdgeInsets.all(margins ?? 25),
          ),
        );

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, width, height);
    canvas.drawRect(rect, Paint()..color = Colors.white10);
    super.render(canvas);
  }
}
