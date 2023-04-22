import 'package:first_app_flutter/modules/acid-base/acidbase.dart';
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
  ),
);

class MyTextBox extends TextBoxComponent with HasGameRef<AcidBaseCheckGame> {
  // double? maximumwidth;
  // double? timePerChar;
  // double? margins;
  double? fontS;
  int type = 0;
  MyTextBox(
    String text, {
    super.align,
    super.size,
    double? timePerChar,
    double? margins,
    double? maximumwidth,
    double? fontS,
  }) : super(
          text: text,
          textRenderer:
              TextPaint(style: _regularTextStyle.copyWith(fontSize: fontS)),
          boxConfig: TextBoxConfig(
            maxWidth: maximumwidth ?? 700,
            timePerChar: timePerChar ?? 0.00,
            growingBox: false,
            margins: EdgeInsets.all(margins ?? 25),
          ),
        );

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (type == 1) {
      // final rect = Rect.fromLTWH(0, 0, width, height);
      // canvas.drawRect(rect, Paint()..color = Colors.white10);
    }
    super.render(canvas);
  }

  @override
  Future<void> onLoad() {
    // TODO: implement onLoad
    if (type == 1) {}
    return super.onLoad();
  }
}
