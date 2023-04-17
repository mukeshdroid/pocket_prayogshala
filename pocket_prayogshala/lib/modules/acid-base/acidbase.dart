import 'dart:math';
import 'liquidlevel.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import 'objects/beaker.dart';

class acidBasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: AcidBaseGame());
  }
}

class AcidBaseGame extends FlameGame with DragCallbacks {
  SpriteComponent backgroundImage = SpriteComponent();
  Beaker beaker = Beaker();
  // Waterlevel waterlevel = Waterlevel();
  final double characterSize = 180;
  RectangleComponent rect = RectangleComponent();
  LiquidLevel liquidLevel = LiquidLevel();

  @override
  Future<void> onLoad() async {
    final screenWidth = size[0];
    final screenHeight = size[1];
    await super.onLoad();

    final double beakerSize = 180 * 1.3;
    beaker
      ..size = Vector2(beakerSize, beakerSize)
      ..y = screenHeight / 2 + 140
      ..x = screenWidth / 2;
    backgroundImage
      ..sprite = await loadSprite('back.jpg')
      ..size = size;
    add(backgroundImage);

    add(rect);
    add(liquidLevel);
    add(beaker);
    liquidLevel.add(liquidLevel.colorEffect);
  }

  @override
  void update(double dt) {
    super.update(dt);
    liquidLevel.add(liquidLevel.colorEffect);
  }
}
