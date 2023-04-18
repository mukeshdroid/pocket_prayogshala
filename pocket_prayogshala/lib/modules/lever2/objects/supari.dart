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

  late Sprite sprite1;
  late Sprite sprite2;
  late Sprite sprite3;
  late Sprite sprite4;
  late Sprite spritecracked;

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
    print(size);
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
      updateSprite(sprite1);
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
        updateSprite(sprite2);
      } else if (fratio <= 5 && fratio > 3) {
        updateSprite(sprite3);
      } else if (fratio <= 3 && fratio > 1) {
        updateSprite(sprite4);
      } else if (fratio <= 1) {
        updateSprite(spritecracked);
      } else {
        updateSprite(sprite1);
      }
    }
  }

  void updateSprite(Sprite newSprite) {
    sprite = newSprite;
    size = Vector2(gameRef.supariSize[index], gameRef.supariSize[index]);
  }
}
