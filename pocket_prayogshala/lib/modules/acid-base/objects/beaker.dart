import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import 'package:flame/components.dart';
import '../acidbase.dart';

class Beaker extends SpriteComponent with HasGameRef<AcidBaseGame> {
  Beaker({super.size});
  final double beakerSize = 180 * 1.3;

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('beaker.png');
    anchor = Anchor.center;
    size = Vector2(beakerSize, beakerSize);
    y = gameRef.size[1] / 2 + 140;
    x = gameRef.size[0] / 2;
    priority = 3;
  }
}
