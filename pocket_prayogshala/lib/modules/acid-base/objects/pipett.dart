import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import '../acidbase.dart';

class Pipett extends SpriteComponent
    with HasGameRef<AcidBaseCheckGame>, DragCallbacks {
  Pipett({super.size});
  bool _isDragged = false;
  bool full = false;
  bool snappedToFill = false;
  bool snappedToRelease = false;
  Vector2 temp_Position = Vector2(0, 0);
  late Vector2 initialPosition = Vector2(100, 100);
  double volume = 0;
  String reagent = 'water';
  double maxVolume = .3;
  static double snapSeperation = 180;
  Vector2 snapPosition = Vector2.zero();
  late Sprite spritefull;
  late Sprite spriteempty;
  List releaseSnappablePosition = [];
  List fillSnappablePosition = [];
  // late Vector2 tempSize;

  @override
  void onLoad() async {
    super.onLoad();
    spritefull = await Sprite.load('pipettefull.png');
    spriteempty = await Sprite.load('pipetteempty.png');
    final screenWidth = gameRef.size[0];
    final screenHeight = gameRef.size[1];
    // initialPosition = Vector2(size.x, size.y);
    releaseSnappablePosition.add(Vector2(screenWidth * .5, screenHeight * .65));
    fillSnappablePosition.add(Vector2(screenWidth * .20, screenHeight * .75));
    fillSnappablePosition.add(Vector2(screenWidth * .80, screenHeight * .75));
    print(fillSnappablePosition);
  }

  @override
  void update(dt) {
    super.update(dt);
    if (full) {
      sprite = spritefull;
      size = Vector2(gameRef.size[1] / 20, gameRef.size[1] / 20 * 5.75);
    } else {
      sprite = spriteempty;
      size = Vector2(gameRef.size[1] / 20, gameRef.size[1] / 20 * 5.75);
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    _isDragged = true;
    temp_Position = Vector2.copy(position);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.delta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
    if (!full) {
      if (checkForSnapFill()) {
        // start filling animation and wait until animation ends
        // move to initial position with filled pipette
        snappedToRelease = false;
        snappedToFill = true;
        // if button on pipette pressed, fill

        fill();
      }
    } else {
      if (checkForSnapRelease()) {
        // if pressed the button on pipette,
        // start release animation and wait until animation ends
        snappedToFill = false;
        snappedToRelease = true;
        // if button on pipette pressed, release
        release();
      }
    }
  }

  fill() {
    // fills the pipette with the given reagent
    print('pipette filled at ');

    full = true;
  }

  release() {
    // functions that dispenses the substance in pipett
    // if the pipett is set at the required position and
    // the pipett is not empty.
    if (full) {
      gameRef.liquid.currentAgent = reagent;
      print('pipette released');
      full = false;
    }
  }

  bool checkForSnapFill() {
    // check if snappable at fill station

    // initialization of variables
    double minDistance = double.infinity;
    List<double> distance = [];
    int minIndex;

    // list all distances to the snappable positions from
    // current position
    distance = [
      for (var i = 0; i < fillSnappablePosition.length; i++)
        position.distanceTo(fillSnappablePosition[i])
    ];

    //calculating the minumum distances
    // and the index of the minumum distance point
    minDistance = distance.reduce(min);
    minIndex = distance.indexOf(minDistance);

    // check distances and add to the list for snappable
    // for fill purpose

    if (minDistance < snapSeperation) {
      position = fillSnappablePosition[minIndex];
      if (minIndex == 0) {
        reagent = "phenolphthalein";
      } else {
        reagent = "methylOrange";
      }
      print(reagent);
      return true;
    } else {
      //go back to original location
      position = initialPosition;
      return false;
    }
  }

  bool checkForSnapRelease() {
    // checks if snappable to the main beaker

    // initialization of variables
    double minDistance = double.infinity;
    List<double> distance = [];
    int minIndex;

    // list all distances to the snappable positions from
    // current position
    distance = [
      for (var i = 0; i < releaseSnappablePosition.length; i++)
        position.distanceTo(releaseSnappablePosition[i])
    ];

    //calculating the minumum distances
    // and the index of the minumum distance point
    minDistance = distance.reduce(min);
    minIndex = distance.indexOf(minDistance);

    // check distances and add to the list for snappable
    // for fill purpose

    if (minDistance < snapSeperation) {
      position = releaseSnappablePosition[minIndex];
      // snapPosition =
      return true;
    } else {
      //go back to original location
      position = initialPosition;
      return false;
    }
  }
}
