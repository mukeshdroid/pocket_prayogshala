import 'dart:math';
import 'package:first_app_flutter/modules/acid-base/objects/liquid.dart';
import 'package:first_app_flutter/modules/acid-base/objects/pipett.dart';
import 'package:first_app_flutter/modules/acid-base/objects/reagent.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import 'objects/beaker.dart';
import 'objects/reagent.dart';
import 'objects/textBox.dart';

class acidBasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: AcidBaseCheckGame());
  }
}

class AcidBaseCheckGame extends FlameGame with DragCallbacks {
  SpriteComponent backgroundImage = SpriteComponent();
  SpriteComponent beaker = SpriteComponent();
  SpriteComponent beakerPhenolphthalein = SpriteComponent();
  SpriteComponent beakerMethylOrange = SpriteComponent();
  RectangleComponent rect = RectangleComponent();
  final double beakerSize = 180 * 1.3;
  Liquid liquid = Liquid();
  Reagent phenoph = Reagent();
  Reagent methyl = Reagent();
  Pipett pipett = Pipett();
  MyTextBox forceDisplay = MyTextBox(
    "Force : - N",
  );

  @override
  Future<void> onLoad() async {
    final screenWidth = size[0];
    final screenHeight = size[1];
    await super.onLoad();
    backgroundImage
      ..sprite = await loadSprite('acidbaseback.jpg')
      ..size = size
      ..priority = 0;

    add(backgroundImage);

    // ratio 1:5.75
    pipett
      ..sprite = await loadSprite('pipette.png')
      ..anchor = Anchor.bottomCenter
      ..size = Vector2(screenWidth / 20, screenWidth / 20 * 5.75)
      ..y = 0.5 * screenHeight
      ..x = 0.05 * screenWidth
      ..initialPosition = Vector2(0.05 * screenWidth, 0.5 * screenHeight)
      ..priority = 5;

    beaker
      ..sprite = await Sprite.load('beaker.png')
      ..anchor = Anchor.bottomCenter
      ..size = Vector2(0.25 * screenWidth, 0.25 * screenWidth)
      ..y = screenHeight * .8
      ..x = screenWidth / 2
      ..priority = 5;

    beakerPhenolphthalein
      ..sprite = await loadSprite('beaker.png')
      ..anchor = Anchor.bottomCenter
      ..size = Vector2(0.15 * screenWidth, 0.15 * screenWidth)
      ..y = screenHeight * .8
      ..x = screenWidth * .20
      ..priority = 5;
    // print('the size is $size');

    beakerMethylOrange
      ..sprite = await loadSprite('beakerMeth.png')
      ..size = Vector2(0.15 * screenWidth, 0.15 * screenWidth)
      ..anchor = Anchor.bottomCenter
      ..y = screenHeight * .8
      ..x = screenWidth * .80
      ..priority = 5;

    liquid
      ..anchor = Anchor.bottomCenter
      ..y = screenHeight * .8
      ..x = screenWidth / 2
      ..width = 0.205 * screenWidth * .845
      ..amountOfAcid = 1000
      ..priority = 3;
    add(liquid);

    phenoph
      ..anchor = Anchor.bottomCenter
      ..y = screenHeight * .8
      ..x = screenWidth * .8
      ..width = 0.205 * screenWidth * .5
      ..currentAgent = 'phenolphthalein'
      ..priority = 3;
    add(phenoph);

    methyl
      ..anchor = Anchor.bottomCenter
      ..y = screenHeight * .8
      ..x = screenWidth * .2
      ..width = 0.205 * screenWidth * .5
      ..currentAgent = 'methylOrange'
      ..priority = 3;
    add(methyl);

    forceDisplay
      ..anchor = Anchor.topCenter
      ..x = screenWidth / 2
      ..y = screenHeight / 15;
    add(forceDisplay);

    add(pipett);
    add(beakerPhenolphthalein);
    add(beakerMethylOrange);
    add(beaker);
  }

  @override
  void update(double dt) {
    super.update(dt);
    liquid.add(ColorEffect(liquid.currentColor, const Offset(0.0, 1),
        EffectController(duration: 0.0)));
    liquid.add(
        OpacityEffect.to(liquid.liquidOpacity, EffectController(duration: 0)));

    phenoph.add(ColorEffect(phenoph.currentColor, const Offset(0.0, 1),
        EffectController(duration: 0.0)));
    phenoph.add(
        OpacityEffect.to(phenoph.liquidOpacity, EffectController(duration: 0)));

    methyl.add(ColorEffect(methyl.currentColor, const Offset(0.0, 1),
        EffectController(duration: 0.0)));
    methyl.add(
        OpacityEffect.to(methyl.liquidOpacity, EffectController(duration: 0)));
  }
}
