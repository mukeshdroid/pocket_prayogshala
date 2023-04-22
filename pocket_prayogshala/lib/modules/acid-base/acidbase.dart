import 'dart:math';
import 'package:first_app_flutter/modules/acid-base/objects/liquid.dart';
import 'package:first_app_flutter/modules/acid-base/objects/pipett.dart';
import 'package:first_app_flutter/modules/acid-base/objects/reagent.dart';
import 'package:first_app_flutter/modules/acid-base/objects/tapbutton.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import 'objects/beaker.dart';
import 'objects/reagent.dart';
import 'objects/textBoxAcid.dart';

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
  SpriteComponent table = SpriteComponent();
  RectangleComponent rect = RectangleComponent();
  final double beakerSize = 180 * 1.3;
  Liquid liquid = Liquid();
  Reagent phenoph = Reagent();
  Reagent methyl = Reagent();
  Pipett pipett = Pipett();
  TapButton nextButton = TapButton();
  TapButton retryButton = TapButton();

  late MyTextBox questionDisplay;
  late MyTextBox textMainBeaker;
  late MyTextBox textPhenBeaker;
  late MyTextBox textMethBeaker;

  @override
  Future<void> onLoad() async {
    final screenWidth = size[0];
    final screenHeight = size[1];
    double beakerY = screenHeight * .75;
    double beakerMainX = screenWidth / 2;
    double beakerPhenX = screenWidth * .2;
    double beakerMethX = screenWidth * .8;
    await super.onLoad();
    backgroundImage
      ..sprite = await loadSprite('acidbaseback.jpg')
      ..size = size
      ..priority = 0;
    add(backgroundImage);

    //buttons
    nextButton
      ..hoveredAssetname = 'acidbuttonunpressed.png'
      ..nothoveredAssetname = 'acidbuttonpressed.png'
      ..x = (beakerMethX + beakerMainX) / 2
      ..y = beakerY + 0.08 * screenHeight
      ..priority = 5
      ..assignedSize =
          Vector2(screenWidth * 0.15, screenWidth * 0.15 * (375 / 624))
      ..anchor = Anchor.topCenter;
    add(nextButton);

    retryButton
      ..hoveredAssetname = 'basebuttonunpressed.png'
      ..nothoveredAssetname = 'basebuttonpressed.png'
      ..x = (beakerPhenX + beakerMainX) / 2
      ..y = beakerY + 0.08 * screenHeight
      ..priority = 5
      ..assignedSize =
          Vector2(screenWidth * 0.15, screenWidth * 0.15 * (375 / 624))
      ..anchor = Anchor.topCenter;
    add(retryButton);

    // ratio 1:5.75
    pipett
      ..sprite = await loadSprite('pipette.png')
      ..anchor = Anchor.bottomCenter
      ..size = Vector2(screenWidth / 20, screenWidth / 20 * 5.75)
      ..y = 0.5 * screenHeight
      ..x = 0.08 * screenWidth
      ..initialPosition = Vector2(0.05 * screenWidth, 0.5 * screenHeight)
      ..priority = 5;

    beaker
      ..sprite = await Sprite.load('beaker.png')
      ..anchor = Anchor.bottomCenter
      ..size = Vector2(0.25 * screenWidth, 0.25 * screenWidth)
      ..y = beakerY
      ..x = beakerMainX
      ..priority = 5;

    beakerPhenolphthalein
      ..sprite = await loadSprite('beaker.png')
      ..anchor = Anchor.bottomCenter
      ..size = Vector2(0.15 * screenWidth, 0.15 * screenWidth)
      ..y = beakerY
      ..x = beakerPhenX
      ..priority = 5;

    beakerMethylOrange
      ..sprite = await loadSprite('beakerMeth.png')
      ..size = Vector2(0.15 * screenWidth, 0.15 * screenWidth)
      ..anchor = Anchor.bottomCenter
      ..y = beakerY
      ..x = beakerMethX
      ..priority = 5;

    liquid
      ..anchor = Anchor.bottomCenter
      ..y = beakerY
      ..x = screenWidth / 2
      ..width = 0.205 * screenWidth * .845
      ..amountOfAcid = 1000
      ..priority = 3;
    add(liquid);

    table
      ..sprite = await loadSprite('acidbasetable.png')
      ..anchor = Anchor.topCenter
      ..size = Vector2(screenWidth, 0.350 * screenWidth)
      ..y = beakerY
      ..x = screenWidth / 2
      ..priority = 3;
    add(table);

    phenoph
      ..anchor = Anchor.bottomCenter
      ..y = beakerY
      ..x = beakerPhenX
      ..width = 0.205 * screenWidth * .5
      ..currentAgent = 'phenolphthalein'
      ..priority = 3;
    add(phenoph);

    methyl
      ..anchor = Anchor.bottomCenter
      ..y = beakerY
      ..x = beakerMethX
      ..width = 0.205 * screenWidth * .5
      ..currentAgent = 'methylOrange'
      ..priority = 3;
    add(methyl);

    questionDisplay = MyTextBox('क्षार हो की अम्ल ? पत्ता लगाउनुहोस |   ',
        timePerChar: .1,
        maximumwidth: screenWidth * .7,
        fontS: 30 * (screenWidth / 900));
    questionDisplay
      ..anchor = Anchor.topLeft
      ..x = screenWidth * .15
      ..y = screenHeight / 15
      ..priority = 5
      ..type = 1
      ..fontS = 30 * (screenWidth / 900)
      ..size = Vector2(screenWidth, screenHeight / 9);
    add(questionDisplay);

    textMainBeaker = MyTextBox('तत्काल राखिएको अभिक्रमक : खाली',
        maximumwidth: screenWidth * .7, fontS: 17 * (screenWidth / 900));
    textMainBeaker
      ..anchor = Anchor.center
      ..align = Anchor.center
      ..fontS = 17 * (screenWidth / 900)
      ..x = screenWidth / 2
      ..y = beakerY + 0.025 * screenHeight
      ..priority = 5
      ..size = Vector2(screenWidth / 10, screenHeight / 15);
    add(textMainBeaker);

    textPhenBeaker = MyTextBox('फेनोल्पथाइलीन ',
        maximumwidth: screenWidth * .4, fontS: 17 * (screenWidth / 900));
    textPhenBeaker
      ..anchor = Anchor.center
      ..align = Anchor.center
      ..fontS = 17 * (screenWidth / 900)
      ..x = beakerPhenX
      ..y = beakerY + 0.025 * screenHeight
      ..priority = 5
      ..size = Vector2(screenWidth, screenHeight / 9);
    add(textPhenBeaker);

    textMethBeaker = MyTextBox('मिथायल ऑरेंज',
        maximumwidth: screenWidth * .4, fontS: 17 * (screenWidth / 900));
    textMethBeaker
      ..anchor = Anchor.center
      ..align = Anchor.center
      ..fontS = 17 * (screenWidth / 900)
      ..x = beakerMethX
      ..y = beakerY + 0.025 * screenHeight
      ..priority = 5
      ..size = Vector2(screenWidth, screenHeight / 9);
    add(textMethBeaker);

    add(pipett);
    add(beakerPhenolphthalein);
    add(beakerMethylOrange);
    add(beaker);
  }

  @override
  void update(double dt) {
    super.update(dt);
    print(size);
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
