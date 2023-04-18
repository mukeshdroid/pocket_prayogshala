import 'dart:math';
import 'package:first_app_flutter/modules/acid-base/objects/liquid.dart';
import 'package:first_app_flutter/modules/acid-base/objects/pipett.dart';
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
    return GameWidget(game: AcidBaseCheckGame());
  }
}

class AcidBaseCheckGame extends FlameGame with DragCallbacks {
  SpriteComponent backgroundImage = SpriteComponent();
  Beaker beaker = Beaker();
  SpriteComponent beakerPhenolphthalein = SpriteComponent();
  SpriteComponent beakerMethylOrange = SpriteComponent();
  RectangleComponent rect = RectangleComponent();
  final double beakerSize = 180 * 1.3;
  Liquid liquid = Liquid();
  Pipett pipett = Pipett();

  @override
  Future<void> onLoad() async {
    final screenWidth = size[0];
    final screenHeight = size[1];
    await super.onLoad();

    beaker
      ..size = Vector2(beakerSize, beakerSize)
      ..anchor = Anchor.bottomCenter
      ..y = screenHeight / 2 + 140
      ..x = screenWidth / 2
      ..priority = 3;
    backgroundImage
      ..sprite = await loadSprite('bg.jpg')
      ..size = size
      ..priority = 1;
    pipett
      ..sprite = await loadSprite('bg.jpg')
      ..size = Vector2(150, 150)
      ..y = 140
      ..x = 200
      ..priority = 5;
    beakerPhenolphthalein
      ..sprite = await loadSprite('bg.jpg')
      ..size = Vector2(150, 150)
      ..anchor = Anchor.bottomCenter
      ..y = screenHeight / 2 + 260
      ..x = screenWidth / 2 + screenWidth / 4 + screenWidth / 16
      ..priority = 5;
    // print('the size is $size');

    beakerMethylOrange
      ..sprite = await loadSprite('bg.jpg')
      ..size = Vector2(150, 150)
      ..anchor = Anchor.bottomCenter
      ..y = screenHeight / 2 + 260
      ..x = screenWidth / 2 - screenWidth / 4 - screenWidth / 16
      ..priority = 4;

    add(pipett);
    // add(backgroundImage);
    add(beakerPhenolphthalein);
    add(beakerMethylOrange);
    add(beaker);
    add(liquid);
  }

  @override
  void update(double dt) {
    super.update(dt);
    liquid.add(ColorEffect(liquid.currentColor, const Offset(0.0, 1),
        EffectController(duration: 0.0)));
    liquid.add(
        OpacityEffect.to(liquid.liquidOpacity, EffectController(duration: 0)));
  }
}