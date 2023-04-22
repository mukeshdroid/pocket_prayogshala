import 'dart:io';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import '../acidbase.dart';
import 'dart:math';

class Liquid extends SpriteComponent with HasGameRef<AcidBaseCheckGame> {
  Liquid({super.size});
  // late double amountOfAcid = 0;
  late double amountOfAcid = 0;
  late double amountOfBase = 0;
  late double width = 0.15 * gameRef.size[0];
  double volume = 0;
  double totalVolume = 500;
  late String currentAgent = 'water';
  late Color currentColor;
  late double liquidOpacity;
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
    calculateOpacity();
    int colorDelta = 0;
    bool acid;
    double scaledAmount = (amountOfAcid - amountOfBase) / 10;
    (amountOfAcid - amountOfBase) < 0 ? acid = false : acid = true;
    acid ? colorDelta = 0 : colorDelta = 3;
    if (currentAgent == 'water') {
      currentColor = Color.fromRGBO(
          agent[currentAgent]?[0 + colorDelta],
          agent[currentAgent]?[1 + colorDelta],
          agent[currentAgent]?[2 + colorDelta],
          minOpacity);
    } else if (currentAgent == 'phenolphthalein') {
      currentColor = Color.fromRGBO(
          agent[currentAgent]?[0 + colorDelta],
          agent[currentAgent]?[1 + colorDelta],
          agent[currentAgent]?[2 + colorDelta],
          liquidOpacity);
    } else if (currentAgent == 'methylOrange') {
      currentColor = Color.fromRGBO(
          agent[currentAgent]?[0 + colorDelta],
          agent[currentAgent]?[1 + colorDelta],
          agent[currentAgent]?[2 + colorDelta],
          liquidOpacity);
    } else {
      currentAgent = 'water';
      currentColor = Color.fromRGBO(
          agent[currentAgent]?[0 + colorDelta],
          agent[currentAgent]?[1 + colorDelta],
          agent[currentAgent]?[2 + colorDelta],
          liquidOpacity);
    }
  }

// function to calculate and set the variable of liquidOpacity to the required
// value of opacity required given a currentAgent
  void calculateOpacity() {
    bool acid;
    double scaledAmount = (amountOfAcid - amountOfBase) / 10;
    double scaledSigmoid = sigmoid(scaledAmount).abs();
    sigmoid(scaledAmount).abs() < minOpacity
        ? scaledSigmoid = minOpacity
        : scaledSigmoid;
    (amountOfAcid - amountOfBase) < 0 ? acid = false : acid = true;
    if (currentAgent == 'water') {
      liquidOpacity = minOpacity;
    } else if (currentAgent == 'phenolphthalein') {
      if (acid) {
        liquidOpacity = minOpacity;
      } else {
        liquidOpacity = scaledSigmoid;
      }
    } else if (currentAgent == 'methylOrange') {
      liquidOpacity = scaledSigmoid;
    } else {
      currentAgent = 'water';
      liquidOpacity = minOpacity;
    }
  }

  double sigmoid(double x) {
    return (exp(x) - exp(-x)) / (exp(x) + exp(-x));
  }

  static Map<String, List> agent = {
    'water': [173, 216, 230, 173, 216, 230],
    'phenolphthalein': [173, 216, 230, 255, 0, 0],
    'methylOrange': [255, 0, 0, 225, 225, 0],
  };
}
