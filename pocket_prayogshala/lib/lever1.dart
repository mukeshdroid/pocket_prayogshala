import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'dart:ui' hide TextStyle;
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/rendering.dart';

Vector2 updateSnapPos(Vector2 vector, Vector2 center, double angle) {
  Vector2 temp1 = vector - center;
  Vector2 temp2 = vector - center;
  temp1.x = temp1.x * cos(angle) - temp1.y * sin(angle);
  temp2.y = temp2.x * sin(angle) + temp2.y * cos(angle);
  return Vector2(temp1.x + center.x, temp2.y + center.y);
}

class Lever1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: Lever1Game());
  }
}

class Lever1Game extends FlameGame with DragCallbacks {
  // late Player player;
  SpriteComponent backgroundImage = SpriteComponent();
  SpriteComponent plankRod = SpriteComponent();
  SpriteComponent fulcrum = SpriteComponent();
  SpriteComponent grass = SpriteComponent();
  // TextComponent weight = TextComponent('10kg');
  List<MyDragSpriteComponent> weights = [];
  List<MyDragSpriteComponent> humans = [];
  List<int> takenPosition = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  // this is initialized when the student asks presses the execute button

  // initialized as 1 for testing ( plank rod starts rotating clockwise)
  int tilt = 1;
  // by how much should the lever be tilted
  double maxTiltAngle = pi / 10;
  double minSnappingAngle = 0.01;
  static late double fulcrumPoint;
  List<Vector2> snappablePositions = [];
  List<Vector2> snappablePositionsMain = [];
  late double gap;

  late final style = TextStyle(color: Color(0xffffffff));
  late final regular = TextPaint(style: style);
  // !!!!!!!!!!!!
  // this might not work for testing
  // @override
  // void onGameResize(Vector2 canvasSize) async {
  //   // TODO: implement onGameResize
  //   super.onGameResize(canvasSize);
  //   await onLoad();
  // }

  @override
  Future<void> onLoad() async {
    final screenWidth = size[0];
    final screenHeight = size[1];

    await super.onLoad();

    backgroundImage
      ..sprite = await loadSprite('sky.jpg')
      ..size = size;

    add(backgroundImage);

    plankRod
      ..anchor = Anchor.bottomCenter
      ..sprite = await loadSprite('plank.png')
      ..size = Vector2(0.7 * screenWidth, 0.05 * screenHeight)
      ..y = screenHeight * 0.52
      ..priority = 1
      ..x = screenWidth / 2;
    add(plankRod);

    gap = plankRod.size.x / 10;

    fulcrum
      ..anchor = Anchor.center
      ..sprite = await loadSprite('plankBase.png')
      ..size = Vector2(0.1 * screenWidth, 0.25 * screenHeight)
      ..y = screenHeight / 2 + 0.11 * screenHeight
      ..priority = 0
      ..x = screenWidth / 2;
    add(fulcrum);

    grass
      ..anchor = Anchor.topCenter
      ..sprite = await loadSprite('grass.png')
      ..size = Vector2(screenWidth, 0.5 * screenHeight)
      ..y = screenHeight / 2 + 0.2 * screenHeight
      ..x = screenWidth / 2;
    add(grass);

    add(TextComponent(text: 'Hello, Flame', textRenderer: regular)
      ..anchor = Anchor.topCenter
      ..x = screenWidth / 2 // size is a property from game
      ..y = 32.0);

    print(plankRod.size);
    for (int i = 0; i < 5; i++) {
      snappablePositionsMain
          .add(Vector2(plankRod.x - plankRod.size.x / 2 + i * gap, plankRod.y));
    }
    for (int i = 0; i < 5; i++) {
      snappablePositionsMain
          .add(Vector2(plankRod.x + (i + 1) * gap, plankRod.y));
    }
    snappablePositions = snappablePositionsMain.toList();

    fulcrumPoint = fulcrum.x;
    for (int i = 1; i <= 5; i++) {
      int tempX = 0;
      MyDragSpriteComponent weight = MyDragSpriteComponent()
        ..anchor = Anchor.center
        ..sprite = await loadSprite('weight.png')
        ..size = Vector2(30, 30) + Vector2(4, 4) * i.toDouble()
        ..y = screenHeight - 30 - 2 * i
        ..x = screenWidth - 50 - pow(i, 1.3) * 27
        ..initialPosition = Vector2(
            screenWidth - 50 - pow(i, 1.3) * 27, screenHeight - 30 - 2 * i)
        ..objectWeight = 10 + 10 * i
        ..human = false;
      weights.add(weight);
      add(weights[i - 1]);
    }

    for (int i = 1; i <= 5; i++) {
      MyDragSpriteComponent human = MyDragSpriteComponent()
        ..anchor = Anchor.center
        ..sprite = await loadSprite('boy.png')
        ..size = Vector2(80, 80) + Vector2(4, 4) * i.toDouble()
        ..y = screenHeight - 50 - 2 * i
        ..x = 50.0 + 44 * i
        ..initialPosition = Vector2(50.0 + 44 * i, screenHeight - 50 - 2 * i)
        ..objectWeight = 10 + 10 * i
        ..human = true;
      humans.add(human);
      add(humans[i - 1]);
    }
  }

  int isBalanced() {
    int rightSum = 0;
    int leftSum = 0;
    weights.forEach((element) {
      if (element.onWeight == true) {
        if (element.onBalancePos < 5) {
          leftSum =
              leftSum + element.objectWeight * (5 - element.onBalancePos).abs();
        } else {
          rightSum =
              rightSum + element.objectWeight * (element.onBalancePos - 4);
        }
      }
    });
    humans.forEach((element) {
      if (element.onWeight == true) {
        if (element.onBalancePos < 5) {
          leftSum =
              leftSum + element.objectWeight * (5 - element.onBalancePos).abs();
        } else {
          rightSum =
              rightSum + element.objectWeight * (element.onBalancePos - 4);
        }
      }
    });
    if (leftSum == rightSum) {
      return 0;
    } else if (leftSum > rightSum) {
      return -1;
    } else {
      return 1;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    tilt = isBalanced();
    if (plankRod.angle >= -100 && plankRod.angle <= 0.0 && tilt == 0) {
      if (plankRod.angle.abs() <= minSnappingAngle) {
        plankRod.angle = 0;
      } else {
        plankRod.angle += .5 * dt;
      }
    } else if (plankRod.angle <= 100 && plankRod.angle >= 0.0 && tilt == 0) {
      if (plankRod.angle.abs() <= minSnappingAngle) {
        plankRod.angle = 0;
      } else {
        plankRod.angle -= .5 * dt;
      }
    } else if (plankRod.angle <= -maxTiltAngle && tilt == -1) {
      tilt = 1;
    } else if (plankRod.angle >= maxTiltAngle && tilt == 1) {
      tilt = -1;
    } else if (tilt == 1) {
      plankRod.angle += .5 * dt;
    } else if (tilt == -1) {
      plankRod.angle -= .5 * dt;
    }
    late int tempIndex;

    for (int i = 1; i < 5; i++) {}
    weights.forEach((element) {
      if (element.onWeight == true && element._isDragged == false) {
        element.angle = plankRod.angle;
        // element.x = plankRod.x - snappablePositions[element.onBalancePos] * cos(element.angle);
        // element.y = plankRod.y - element.distFromFulcrum * sin(element.angle);
        //alternative form for calculating distFromFulcrum
        element.x = snappablePositions[element.onBalancePos].x;
        element.y = snappablePositions[element.onBalancePos].y;
      }
    });
    humans.forEach((element) {
      if (element.onWeight == true && element._isDragged == false) {
        element.angle = plankRod.angle;
        // element.x = plankRod.x - element.distFromFulcrum * cos(element.angle);
        // element.y = plankRod.y - element.distFromFulcrum * sin(element.angle);
        element.x = snappablePositions[element.onBalancePos].x;
        element.y = snappablePositions[element.onBalancePos].y;
      }
    });
    //

    //update snappable positions acc to angle
    Vector2 center = Vector2(plankRod.x, plankRod.y);
    snappablePositions = [];
    for (int i = 0; i < 5; i++) {
      snappablePositions.add(
          updateSnapPos(snappablePositionsMain[i], center, plankRod.angle));
    }
    for (int i = 5; i < 10; i++) {
      snappablePositions.add(
          updateSnapPos(snappablePositionsMain[i], center, plankRod.angle));
    }

    print(snappablePositions);
  }
}

class MyDragSpriteComponent extends SpriteComponent
    with DragCallbacks, HasGameRef<Lever1Game> {
  MyDragSpriteComponent({super.size});

  static List<Vector2> snappablePositions = [];

  @override
  FutureOr<void> onLoad() {
    return super.onLoad();
    snappablePositions = gameRef.snappablePositions;
    gameRef
        .add((TextComponent(text: 'Hello, Flame', textRenderer: gameRef.regular)
          ..anchor = Anchor.topCenter
          ..x = gameRef.size[0] / 2 // size is a property from game
          ..y = 32.0));
  }

  static double snapDistance = 80;
  // index of where the position of the object is
  // 1000 implies does not exist on balance
  int onBalancePos = 1000;
  bool onWeight = false;
  // this is temporary
  late double distFromFulcrum;
  // final _paint = Paint();
  bool _isDragged = false;
  bool human = false;
  late Vector2 initialPosition;
  late Vector2 currentPosition;
  late int objectWeight;

  Vector2 temp_Position = Vector2(0, 0);

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
    late bool snappable;
    (minDistance <= snapDistance && gameRef.takenPosition[minIndex] == 0)
        ? snappable = true
        : snappable = false;
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
    distFromFulcrum = ((gameRef.plankRod.size.x) - snapPosition.x);
    onWeight = true;
  }
}
