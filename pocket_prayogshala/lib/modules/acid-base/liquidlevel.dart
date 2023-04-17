import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import 'acidbase.dart';
import 'dart:math';

class LiquidLevel extends SpriteComponent with HasGameRef<AcidBaseGame> {
  LiquidLevel({super.size});

  // variables to handle color of water
  int currentOpacity = 50;
  int currentR = 173;
  int currentG = 216;
  int currentB = 230;
  Color currentColor = const Color.fromARGB(255, 173, 216, 230);
  Offset currentOffset = const Offset(0.0, 0.8);
  EffectController effectController = EffectController(duration: 0.5);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    currentColor = Color.fromARGB(currentOpacity, currentR, currentG, currentB);
    sprite = await Sprite.load('back.jpg');
    spritePrep();
  }

  @override
  void update(dt) {
    super.update(dt);
    updateColor();
    spriteUpdate();
    if (volume < 1.0) {
      volume += 0.05 * dt;
    }
  }

  // setting up sprite placements
  void spritePrep() {
    // beaker size is 180 * 1.3 so
    double beakerSize = 180 * 1.3;
    anchor = Anchor.bottomCenter;
    size = Vector2(beakerSize - 15, (volume / totalVolume) * beakerSize);
    y = gameRef.size[1] / 2 + 140 + beakerSize / 2;
    x = gameRef.size[0] / 2;
    priority = 3;
  }

  void spriteUpdate() {
    double beakerSize = 180 * 1.3;
    size = Vector2(beakerSize - 15, (volume / totalVolume) * beakerSize);
    y = gameRef.size[1] / 2 + 140 + beakerSize / 2;
    x = gameRef.size[0] / 2;
  }

  // variables for data and calculation
  double volume = 0;
  double totalVolume = 1.2;
  List liquidsAdded =
      []; // volume of liquid added double and the type of liquid string respectively
  String currentAgent = 'water';

  // a map that gives the substance along with its molarity and
  // the amount of h+ and oh- ion that it dissociates per mole in mole
  static Map<String, Vector3> substance = {
    'water': Vector3(55, 0, 0),
    'acid': Vector3(.05, 0.05, 0),
    'base': Vector3(.05, 0, .05),
  };

  static Map<String, List> agent = {
    'water': [173, 216, 230, 173, 216, 230],
    'phenolphthalein': [173, 216, 230, 255, 255, 0],
    'methylOrange': [173, 216, 230, 225, 225, 0],
  };

  void updateColor2() {}

  void updateColor() {
    double pH = getpH();
    double opacityMultiplier = 1;
    // print('$currentOpacity $currentR $currentG $currentB');
    //to calculate opacity multiplier
    if (currentAgent != 'water') {
      // high/ low ph gives higher value of opacityMultiplier
      (pH < 7)
          ? opacityMultiplier = (7 - pH).abs()
          : opacityMultiplier = (pH - 7).abs();
    } else {
      opacityMultiplier = 1;
    }

    //set the color values corresponding to the scenario
    if (pH < 7) {
      //acidic
      currentOpacity = agent[currentAgent]?[0] * opacityMultiplier.toInt();
      currentR = agent[currentAgent]?[1];
      currentG = agent[currentAgent]?[2];
      currentB = agent[currentAgent]?[3];
    } else {
      //basic
      currentOpacity = agent[currentAgent]?[4] * opacityMultiplier.toInt();
      currentR = agent[currentAgent]?[5];
      currentG = agent[currentAgent]?[6];
      currentB = agent[currentAgent]?[7];
    }
    currentColor = Color.fromARGB(currentOpacity, currentR, currentG, currentB);
  }

  // function to add components to the beaker
  addSolute(double soluteVolume, String solute) {
    // print('adding volume v of solute s');
    volume += soluteVolume;
  }

  ColorEffect get colorEffect =>
      ColorEffect(currentColor, currentOffset, effectController);

  // function that returns the ph of the object
  // used concentration and Kw of water
  double getpH() {
    double conc = 0;
    // start here
    // todo :function to calculate the concentration of h+ of the solution
    // using the list 'liquidsAdded'
    conc = 0.5;
    // end here
    return -1 * log(conc) / ln10;
  }
}
