//import 'dart:ffi';
import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/rendering.dart';

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

  @override
  Future<void> onLoad() async {
    final screenWidth = size[0];
    final screenHeight = size[1];

    await super.onLoad();

    backgroundImage
      ..sprite = await loadSprite('back.jpg')
      ..size = size;

    add(backgroundImage);

    plankRod
      ..anchor = Anchor.center
      ..sprite = await loadSprite('blackline_lever1.png')
      ..size = Vector2(550, 200)
      ..y = screenHeight / 2
      ..x = screenWidth / 2;
    add(plankRod);

    fulcrum
      ..anchor = Anchor.center
      ..sprite = await loadSprite('triangle.png')
      ..size = Vector2(30, 30)
      ..y = screenHeight / 2 + 20
      ..x = screenWidth / 2;
    add(fulcrum);

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

    weights.forEach((element) {
      if (element.onWeight == true && element._isDragged == false) {
        element.angle = plankRod.angle;
        element.x = plankRod.x - element.distFromFulcrum * cos(element.angle);
        element.y = plankRod.y - element.distFromFulcrum * sin(element.angle);
      }
    });
    humans.forEach((element) {
      if (element.onWeight == true && element._isDragged == false) {
        element.angle = plankRod.angle;
        element.x = plankRod.x - element.distFromFulcrum * cos(element.angle);
        element.y = plankRod.y - element.distFromFulcrum * sin(element.angle);
      }
    });
  }
}

class MyDragSpriteComponent extends SpriteComponent
    with DragCallbacks, HasGameRef<Lever1Game> {
  MyDragSpriteComponent({super.size});

  static List<Vector2> snappablePositions = [
    Vector2(250, 310),
    Vector2(300, 310),
    Vector2(350, 310),
    Vector2(400, 310),
    Vector2(450, 310),
    Vector2(550, 310),
    Vector2(600, 310),
    Vector2(650, 310),
    Vector2(700, 310),
    Vector2(750, 310)
  ];

  static double snapDistance = 80;
  // index of where the position of the object is
  // 1000 implies does not exist on balance
  int onBalancePos = 1000;
  bool onWeight = false;
  // this is temporary
  int distFromFulcrum = 250;
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
    for (final positions in snappablePositions) {
      distance.add(positions.distanceTo(position));
    }
    minDistance = distance.fold(
        distance.first, (prev, current) => prev < current ? prev : current);
    int minIndex = distance.indexOf(minDistance);
    snapPosition =
        Vector2(snappablePositions[minIndex].x, snappablePositions[minIndex].y);
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
