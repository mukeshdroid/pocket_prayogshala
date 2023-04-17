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

class MyDragSpriteSupari extends SpriteComponent
    with CollisionCallbacks, DragCallbacks, HasGameRef<Lever2Game> {
  late double crackingForce;
  bool isOnLever = false;

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
  }

  late int index;
  MyDragSpriteSupari({super.size});

  final _paint = Paint();
  bool _isDragged = false;
  bool isOverLappingArm = false;

  @override
  void onDragStart(DragStartEvent event) => _isDragged = true;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.delta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
    snap();
    if (isOverLappingArm) {
      //go back to original location
      position = gameRef.supariLoc[index];
      isOnLever = false;
      isOverLappingArm = false;
      gameRef.whichRung = -1;
      gameRef.whichSupari = -1;
    }
  }

  void snap() {
    //number of snappable positions on downarm

    var dis = [
      for (var i = 0; i < gameRef.downarm.snappablePositions.length; i++)
        position.distanceTo(gameRef.downarm.snappablePositions[i])
    ];

    var minDistance = dis.reduce(min);
    var minIndex = dis.indexOf(minDistance);

    //used this condition now to determine snap. might need updating
    if (minDistance < gameRef.downarm.snapSeperation) {
      /*if another supari is already on the lever,
         send it to its place and place new suapri on lever */

      if (!(gameRef.whichSupari == -1)) {
        gameRef.suparis[gameRef.whichSupari].position =
            gameRef.supariLoc[gameRef.whichSupari];
        gameRef.suparis[gameRef.whichSupari].isOnLever = false;
      }
      gameRef.whichSupari = index;
      isOnLever = true;
      gameRef.whichRung = minIndex;
      position = gameRef.downarm.snappablePositions[minIndex];
    } else {
      //go back to original location
      position = gameRef.supariLoc[index];
      isOnLever = false;
      sprite = gameRef.supariNormal;
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is ScreenHitbox) {
      //...
    } else if (other is MyDragSpriteLeverArm) {
      isOverLappingArm = true;
    }
  }

  @override
  void update(double dt) {
    if (isOnLever) {
      double fratio = crackingForce / (gameRef.leverForce + 1);
      if (fratio < 10 && fratio > 5) {
        sprite = gameRef.supariCrackedlittle;
      } else if (fratio <= 5 && fratio > 3) {
        sprite = gameRef.supariCrackedquarter;
      } else if (fratio <= 3 && fratio > 1) {
        sprite = gameRef.supariCrackedhalf;
      } else if (fratio <= 1) {
        sprite = gameRef.supariCrackedFull;
      } else {
        sprite = gameRef.supariNormal;
      }
    }
  }
}
