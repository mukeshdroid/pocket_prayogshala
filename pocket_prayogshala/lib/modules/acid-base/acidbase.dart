import 'dart:math';
import 'package:pocket_prayogshala/modules/acid-base/objects/liquid.dart';
import 'package:pocket_prayogshala/modules/acid-base/objects/pipett.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import 'objects/beaker.dart';

class acidBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/images/logo.png'),
          title: Text('Pocket Prayogshala'),
        ),
        body: GameWidget(game: AcidBaseCheckGame()) //bodyColumn,
        );
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
  Pipett pipett = Pipett();

  @override
  Future<void> onLoad() async {
    final screenWidth = size[0];
    final screenHeight = size[1];
    await super.onLoad();
    backgroundImage
      ..sprite = await loadSprite('back.jpg')
      ..size = size;

    add(backgroundImage);

    beaker
      ..sprite = await loadSprite('beaker.png')
      ..size = Vector2(beakerSize, beakerSize)
      ..anchor = Anchor.bottomCenter
      ..y = screenHeight * 0.85
      ..x = screenWidth / 2
      ..priority = 3;
    pipett
      ..sprite = await loadSprite('bg.jpg')
      ..size = Vector2(150, 150)
      ..y = 140
      ..x = 200
      ..priority = 5;
    beakerPhenolphthalein
      ..sprite = await loadSprite('beakerPhen.png')
      ..size = Vector2(150, 150)
      ..anchor = Anchor.bottomCenter
      ..y = screenHeight * 0.85
      ..x = screenWidth * 0.2
      ..priority = 5;
    // print('the size is $size');

    beakerMethylOrange
      ..sprite = await loadSprite('beakerMeth.png')
      ..size = Vector2(150, 150)
      ..anchor = Anchor.bottomCenter
      ..y = screenHeight * 0.85
      ..x = screenWidth * 0.8
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
    print(size);
  }
}
