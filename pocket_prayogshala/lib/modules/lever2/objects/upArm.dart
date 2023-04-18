import '../lever2.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:math';
import 'package:flame/experimental.dart';
import 'package:flame/collisions.dart';
import 'downArm.dart';
import 'upArm.dart';
import 'supari.dart';
import 'textBox.dart';

class MyDragSpriteLeverArm extends SpriteComponent
    with CollisionCallbacks, DragCallbacks, HasGameRef<Lever2Game> {
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  MyDragSpriteLeverArm({super.size});

  final _paint = Paint();
  bool _isDragged = false;

  @override
  void onDragStart(DragStartEvent event) => _isDragged = true;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    var delTheta = event.delta[1];
    var resistance = 0.005; //normal resistive force of lever under no load

    //if supari in lever we change resistance accordingly
    if (!(gameRef.whichSupari == -1)) {
      var maxForce = gameRef.suparis[gameRef.whichSupari].crackingForce;
      if (gameRef.leverForce > maxForce) {
        resistance = 0;
      } else {
        resistance = 0.005 - (0.005 / maxForce) * gameRef.leverForce;
      }
    }

    if (angle <= gameRef.maxOpenAngle && angle >= gameRef.minOpenAngle) {
      if (delTheta < 0) {
        angle += 0.005 * delTheta;
      } else {
        angle += resistance * delTheta;
      }
    }
    gameRef.updateForceBoard();
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (!(gameRef.whichSupari == -1)) {
      var maxForce = gameRef.suparis[gameRef.whichSupari].crackingForce;
      if (gameRef.leverForce > maxForce) {
        angle = angle - 0.01;
      }
    }
    _isDragged = false;

    if (angle >= gameRef.maxOpenAngle) {
      angle = gameRef.maxOpenAngle;
    }
    if (angle <= gameRef.minOpenAngle) {
      angle = gameRef.minOpenAngle;
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is ScreenHitbox) {
      //...
    } else if (other is MyDragSpriteSupari) {}
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is ScreenHitbox) {
      //...
    } else if (other is MyDragSpriteSupari) {
      //...
    }
  }
}
