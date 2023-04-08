import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:math';
import 'package:flame/experimental.dart';

class Lever2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: Lever2Game());
  }
}

class MyDragSpriteComponent extends SpriteComponent with DragCallbacks {
  MyDragSpriteComponent({super.size});

  final _paint = Paint();
  bool _isDragged = false;

  @override
  void onDragStart(DragStartEvent event) => _isDragged = true;

  @override
  void onDragUpdate(DragUpdateEvent event) => position += event.delta;

  @override
  void onDragEnd(DragEndEvent event) => _isDragged = false;

  // @override
  // void render(Canvas canvas) {
  //   _paint.color = _isDragged ? Colors.red : Colors.white;
  //   canvas.drawRect(size.toRect(), _paint);
  // }
}

class Lever2Game extends FlameGame with HasDraggableComponents {
  late Player player;
  SpriteComponent uparm = SpriteComponent();
  SpriteComponent downarm = SpriteComponent();
  SpriteComponent backgroundImage = SpriteComponent();
  MyDragSpriteComponent supari1 = MyDragSpriteComponent();
  MyDragSpriteComponent supari2 = MyDragSpriteComponent();
  MyDragSpriteComponent supari3 = MyDragSpriteComponent();

  @override
  Future<void> onLoad() async {
    final screenWidth = size[0];
    final screenHeight = size[1];

    const double leverWidth = 25;
    final double leverLength = screenWidth * 0.5;

    final supari1size = 0.1 * screenHeight;
    final supari2size = 0.15 * screenHeight;
    final supari3size = 0.2 * screenHeight;

    await super.onLoad();

    backgroundImage
      ..sprite = await loadSprite('bg.jpg')
      ..size = size;

    add(backgroundImage);

    player = Player()
      ..position = size / 2
      ..width = 50
      ..height = 100
      ..anchor = Anchor.centerLeft;

    // add(player);

    uparm
      ..anchor = Anchor.centerLeft
      ..sprite = await loadSprite('arm.png')
      ..size = Vector2(leverLength, leverWidth)
      ..y = screenHeight - 150
      ..x = 0.05 * screenWidth
      ..angle = -1.047;

    add(uparm);

    downarm
      ..anchor = Anchor.centerLeft
      ..sprite = await loadSprite('arm.png')
      ..size = Vector2(leverLength, leverWidth)
      ..y = screenHeight - 150
      ..x = 0.05 * screenWidth;

    add(downarm);

    supari1
      ..anchor = Anchor.center
      ..sprite = await loadSprite('supari.png')
      ..size = Vector2(supari1size, supari1size)
      ..y = screenHeight - 150
      ..x = screenWidth - 400;

    add(supari1);

    supari2
      ..anchor = Anchor.center
      ..sprite = await loadSprite('supari.png')
      ..size = Vector2(supari2size, supari2size)
      ..y = screenHeight - 150
      ..x = screenWidth - 300;

    add(supari2);

    supari3
      ..anchor = Anchor.center
      ..sprite = await loadSprite('supari.png')
      ..size = Vector2(supari3size, supari3size)
      ..y = screenHeight - 150
      ..x = screenWidth - 150;

    add(supari3);
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   if (uparm.angle < 0) {
  //     uparm.angle += dt;
  //   }
  //   if (uparm.angle > 0) {
  //     uparm.angle = -1.047;
  //   }
  // }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.game);
  }
}

class Player extends PositionComponent {
  static final _paint = Paint()..color = Colors.white;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
