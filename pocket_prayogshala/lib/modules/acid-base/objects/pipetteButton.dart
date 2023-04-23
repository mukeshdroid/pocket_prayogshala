import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/animation.dart';

enum RobotState {
  idle,
  running,
}

class MySprite extends SpriteAnimationGroupComponent
    with TapCallbacks, HasGameRef {
  late SpriteAnimationGroupComponent robot;

  @override
  Future<void> onLoad() async {
    final running = await gameRef.loadSpriteAnimation(
      'animations/robot.png',
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.2,
        textureSize: Vector2(16, 18),
      ),
    );
    final idle = await gameRef.loadSpriteAnimation(
      'animations/robot-idle.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.4,
        textureSize: Vector2(16, 18),
      ),
    );

    final robotSize = Vector2(64, 72);
    robot = SpriteAnimationGroupComponent<RobotState>(
      animations: {
        RobotState.running: running,
        RobotState.idle: idle,
      },
      current: RobotState.idle,
      position: size / 2 - robotSize / 2,
      size: robotSize,
    );

    add(robot);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    super.onTapDown(event);
    robot.current = RobotState.running;
  }

  @override
  void onTapUp(TapUpEvent event) {
    // TODO: implement onTapUp
    super.onTapUp(event);
    robot.current = RobotState.idle;
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    // TODO: implement onTapCancel
    super.onTapCancel(event);
    robot.current = RobotState.idle;
  }

  @override
  Color backgroundColor() => const Color(0xFF222222);
}
