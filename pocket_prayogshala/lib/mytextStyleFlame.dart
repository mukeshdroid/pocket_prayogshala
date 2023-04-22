import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

final regularTextStyle =
    TextStyle(fontSize: 18, color: BasicPalette.white.color);
final regular = TextPaint(style: regularTextStyle);
final tiny = TextPaint(style: regularTextStyle.copyWith(fontSize: 14.0));
final box = regular.copyWith(
  (style) => style.copyWith(
    color: Colors.lightGreenAccent,
    fontFamily: 'monospace',
    letterSpacing: 2.0,
  ),
);
final shaded = TextPaint(
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
