import 'dart:ffi';
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

class Lever1Game extends FlameGame with HasDraggableComponents {
  // late Player player;
  SpriteComponent backgroundImage = SpriteComponent();
  SpriteComponent plankRod = SpriteComponent();
  SpriteComponent fulcrum = SpriteComponent();
  List<MyDragSpriteComponent> weights = [];
  List<MyDragSpriteComponent> humans = [];
  List<int> takenPosition = [0, 0, 0, 0, 0, 1, 1, 1, 1, 1];
  int tilt = 0;
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
      MyDragSpriteComponent weight = MyDragSpriteComponent()
        ..anchor = Anchor.center
        ..sprite = await loadSprite('weight.png')
        ..size = Vector2(30, 30)
        ..y = screenHeight - 50
        ..x = screenWidth - 50 - (40) * i
        ..initialPosition =
            Vector2(screenWidth - 50 - (40) * i, screenHeight - 50)
        ..human = false;

      weights.add(weight);
      add(weights[i - 1]);
    }

    for (int i = 1; i <= 5; i++) {
      MyDragSpriteComponent human = MyDragSpriteComponent()
        ..anchor = Anchor.center
        ..sprite = await loadSprite('boy.png')
        ..size = Vector2(50, 50)
        ..y = screenHeight - 50
        ..x = 50.0 + 40 * i
        ..initialPosition = Vector2(50.0 + 40 * i, screenHeight - 50)
        ..human = true;
      humans.add(human);
      add(humans[i - 1]);
    }
  }

  @override
  Future<void> onMount() async {
    // await super.onMount();
    // if attached==true
  }

  @override
  void update(double dt) {
    super.update(dt);

    plankRod.angle += .5 * dt;
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

  static double snapDistance = 50;
  int onBalancePos = 0;
  bool onWeight = false;

  // final _paint = Paint();
  bool _isDragged = false;
  bool human = false;
  late Vector2 initialPosition;
  late Vector2 currentPosition;

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
    // print(gameRef.takenPosition);
    if (minDistance <= snapDistance &&
        (((gameRef.takenPosition[minIndex] == 0) && human) ||
            ((gameRef.takenPosition[minIndex] == 1) && !human))) {
      position.setFrom(snapPosition);
      // gameRef.fulcrum.add(MyDragSpriteComponent());
      gameRef.takenPosition[minIndex] = human ? 1 : 2;
    } else {
      position.setFrom(initialPosition);
      if (onWeight == true) gameRef.takenPosition[minIndex] = human ? 0 : 1;
    }
  }
}
