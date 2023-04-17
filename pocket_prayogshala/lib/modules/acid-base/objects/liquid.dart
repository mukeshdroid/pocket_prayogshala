import 'dart:io';

import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import '../acidbase.dart';
import 'dart:math';

class Liquid extends SpriteComponent with HasGameRef<AcidBaseGame> {
  Liquid({super.size});
  late double beakerSize;
  late double amountOfAcid = 0.0;
  late double amountOfBase = 0.0;
  double volume = 0;
  double totalVolume = 1.2;
  String currentAgent = 'water';
  late Color currentColor;
  late double liquidOpacity;

  // determines how much of a difference defines the complete change in color
  double threshhold;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    beakerSize = gameRef.beaker.beakerSize;
    sprite = await Sprite.load('back.jpg');
    spritePrep();
  }

  void update(dt) {
    super.update(dt);
    updateColor();
    spriteUpdate();
    // test
    if (volume < 1.0) {
      volume += 0.05 * dt;
    }
  }

  // setting up sprite placements
  void spritePrep() {
    // Needs to run once
    anchor = Anchor.bottomCenter;
    size = Vector2(beakerSize - 15, (volume / totalVolume) * beakerSize);
    y = gameRef.size[1] / 2 + 140 + beakerSize / 2;
    x = gameRef.size[0] / 2;
    priority = 3;
  }

  void spriteUpdate() {
    size = Vector2(beakerSize - 15, (volume / totalVolume) * beakerSize);
    // y = gameRef.size[1] / 2 + 140 + beakerSize / 2;
    // x = gameRef.size[0] / 2;
  }

  updateColor() {
    calculateOpacity();
    if (currentAgent == 'water') {
      currentColor = Color.fromRGBO(agent[currentAgent]?[0],
          agent[currentAgent]?[0], agent[currentAgent]?[0], 1);
    } else if (currentAgent == 'phenolphthalein') {
      currentColor = Color.fromRGBO(agent[currentAgent]?[0],
          agent[currentAgent]?[0], agent[currentAgent]?[0], liquidOpacity);
    } else if (currentAgent == 'methylOrange') {
      currentColor = Color.fromRGBO(agent[currentAgent]?[0],
          agent[currentAgent]?[0], agent[currentAgent]?[0], liquidOpacity);
    } else {
      currentAgent = 'water';
      currentColor = Color.fromRGBO(agent[currentAgent]?[0],
          agent[currentAgent]?[0], agent[currentAgent]?[0], liquidOpacity);
    }
  }

  calculateOpacity() {
    bool acid;
    bool withinThreshhold;
    (amountOfAcid - amountOfBase) < 0 ? acid = true : acid = false;
    (amountOfAcid - amountOfBase).abs() < threshhold
        ? withinThreshhold = true
        : withinThreshhold = false;
    if (currentAgent == 'water') {
      liquidOpacity = 0.0;
    } else if (currentAgent == 'phenolphthalein') {
      if (acid) {
        liquidOpacity = 0.0;
      } else {
        liquidOpacity = sigmoid((amountOfAcid - amountOfBase));
      }
    } else if (currentAgent == 'methylOrange') {
      liquidOpacity = sigmoid((amountOfAcid - amountOfBase));
    } else {
      currentAgent = 'water';
      liquidOpacity = 0.0;
    }
  }

  double sigmoid(double x) {
    return (exp(x) - exp(-x)) / (exp(x) + exp(-x));
  }

  static Map<String, List> agent = {
    'water': [173, 216, 230, 173, 216, 230],
    'phenolphthalein': [173, 216, 230, 255, 255, 0],
    'methylOrange': [173, 216, 230, 225, 225, 0],
  };
}
