import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/rendering.dart';
import '../lever1.dart';
import 'dart:async';

class MyDragSpriteComponent extends SpriteComponent
    with DragCallbacks, HasGameRef<Lever1Game> {
  MyDragSpriteComponent({super.size});

  static List<Vector2> snappablePositions = [];
  int onBalancePos = 1000;
  bool onWeight = false;
  // this is temporary
  int distFromFulcrum = 250;
  // final _paint = Paint();
  bool isDragged = false;
  bool human = false;
  late Vector2 initialPosition;
  late Vector2 currentPosition;
  late int objectWeight;
  late TextComponent weighttext;

  Vector2 temp_Position = Vector2(0, 0);

  final _regularTextStyle = TextStyle(fontSize: 18, color: Colors.white);

  @override
  FutureOr<void> onLoad() {
    final _tiny = TextPaint(style: _regularTextStyle.copyWith(fontSize: 16.0));
    weighttext = TextComponent(
      text: objectWeight.toString() + 'kg',
      position: Vector2(x, y - size.y),
      textRenderer: _tiny,
    );
    return super.onLoad();
    //snappablePositions = gameRef.snappablePositions;
  }

  static double snapDistance = 80;
  // index of where the position of the object is
  // 1000 implies does not exist on balance

  @override
  void onDragStart(DragStartEvent event) {
    isDragged = true;
    temp_Position = Vector2.copy(position);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.delta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    isDragged = false;
    snap();
  }

  void snap() {
    double minDistance = double.infinity;
    Vector2 snapPosition = Vector2.zero();
    List<double> distance = [];
    for (final positions in gameRef.snappablePositions) {
      distance.add(positions.distanceTo(position));
    }
    minDistance = distance.fold(
        distance.first, (prev, current) => prev < current ? prev : current);
    int minIndex = distance.indexOf(minDistance);
    snapPosition = Vector2(gameRef.snappablePositions[minIndex].x,
        gameRef.snappablePositions[minIndex].y);
    if (!human) {
      snapPosition.y += 10;
    }
    late bool snappable;
    (minDistance <= snapDistance) ? snappable = true : snappable = false;
    // till this point we have
    // minDistance - that gives the distance to the closest snappable point
    // snapPosition - where to snap if snapped
    // minIndex - index of snapPosition
    // snappable - if the snapping criteria is fulfilled
    // onWeight - if the load is on the lever/plank/balance

    if (onWeight == true) {
      if (snappable) {
        // remove the current snap
        resetSnap();
        // transfer to new snap to point with index minIndex
        // and snapPosition = snapPosition
        snapTo(minIndex, snapPosition);
      } else {
        resetSnap();
      }
    } else {
      if (snappable) {
        snapTo(minIndex, snapPosition);
      } else {
        resetSnap();
      }
    }
  }

  @override
  void update(double dt) {
    weighttext.position = Vector2(x, y - size.y);
    weighttext.angle = angle;
    super.update(dt);
  }

  void resetSnap() {
    position.setFrom(initialPosition);
    angle = 0;
    if (onBalancePos != 1000) {
      gameRef.takenPosition[onBalancePos] = 0;
    }
    onBalancePos = 1000;
    onWeight = false;
  }

  void snapTo(index, snapPosition) {
    position.setFrom(snapPosition);
    onBalancePos = index;
    gameRef.takenPosition[index] = 1;
    distFromFulcrum = 500 - position.x.toInt();
    onWeight = true;
  }
}
