import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Lever2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: Lever2Game());
  }
}

class Lever2Game extends FlameGame with PanDetector {
  late Player player;
  SpriteComponent boy = SpriteComponent();
  SpriteComponent girl = SpriteComponent();
  SpriteComponent backgroundImage = SpriteComponent();

  final double characterSize = 180;

  @override
  Future<void> onLoad() async {
    final screenWidth = size[0];
    final screenHeight = size[1];

    await super.onLoad();

    backgroundImage
      ..sprite = await loadSprite('bg.jpg')
      ..size = size;

    add(backgroundImage);

    player = Player()
      ..position = size / 2
      ..width = 50
      ..height = 100
      ..anchor = Anchor.center;

    add(player);

    boy
      ..anchor = Anchor.center
      ..sprite = await loadSprite('boy.png')
      ..size = Vector2(characterSize, characterSize)
      ..y = screenHeight - 100
      ..x = characterSize;

    add(boy);

    girl
      ..anchor = Anchor.center
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2(characterSize, characterSize)
      ..y = screenHeight - 100
      ..x = screenWidth - characterSize;

    add(girl);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (girl.y > size[1] / 2) {
      girl.y -= 30 * dt;
    }
  }

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
