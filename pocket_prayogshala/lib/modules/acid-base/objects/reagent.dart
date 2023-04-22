import 'dart:io';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import '../acidbase.dart';
import 'dart:math';

class Reagent extends SpriteComponent with HasGameRef {
  // Liquid({super.size});
  // late double amountOfAcid = 0;
  late double amountOfAcid = 0;
  late double amountOfBase = 0;
  late double width = 0.15 * gameRef.size[0];
  double volume = 0;
  double totalVolume = 500;
  late String currentAgent = 'water';
  late Color currentColor;
  late double liquidOpacity = 0.3;
  late ColorEffect colorEffect;

  // determines how much of a difference defines the complete change in color
  late double threshhold = 0.2;
  double minOpacity = 0.3;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await Sprite.load('back.jpg');
    // spritePrep();
    updateColor();
    colorEffect = ColorEffect(
        currentColor, const Offset(0.0, 0.9), EffectController(duration: .0));
  }

  void update(dt) {
    super.update(dt);
    updateColor();
    spriteUpdate();

    // test
    if (volume < totalVolume) {
      volume += 50 * dt;
    }
  }

  // setting up sprite placements
  // void spritePrep() {
  //   // Needs to  be run once to set up placement of luquid
  // }
  void spriteUpdate() {
    size = Vector2(width, (volume / totalVolume) * width);
  }

  updateColor() {
    currentAgent = 'water';
    currentColor = Color.fromRGBO(173, 216, 230, liquidOpacity);
  }
}
