import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:math';
import 'package:flame/experimental.dart';
import 'objects/downArm.dart';
import 'objects/upArm.dart';
import 'objects/supari.dart';
import 'objects/textBox.dart';

class Lever2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: Lever2Game());
  }
}

//game class for second class lever
class Lever2Game extends FlameGame with DragCallbacks, HasCollisionDetection {
  //late Player player;
  MyDragSpriteLeverArm uparm = MyDragSpriteLeverArm();
  MyNonDragSpriteLeverArm downarm = MyNonDragSpriteLeverArm();
  SpriteComponent backgroundImage = SpriteComponent();
  List<MyDragSpriteSupari> suparis = [];
  MyTextBox forceDisplay = MyTextBox(
    "Force : - N",
  );

  //gives the index of supari which is on lever. -1 for none
  int whichSupari = -1;

  //gives the rung on which we have the supari. -1 fpr none
  int whichRung = -1;

  double minOpenAngle = -pi / 3;
  double maxOpenAngle = 0;

  late double screenWidth;
  late double screenHeight;

  late Sprite supariCrackedFull;
  late Sprite supariCrackedquarter;
  late Sprite supariCrackedhalf;
  late Sprite supariCrackedlittle;
  late Sprite supariNormal;

  late List<Vector2> supariLoc;
  late List<double> supariSize;

  double leverForce = 0;

  @override
  Future<void> onLoad() async {
    screenWidth = size[0];
    screenHeight = size[1];

    const double leverWidth = 25;
    final double leverLength = screenWidth * 0.5;

    await super.onLoad();
    backgroundImage
      ..sprite = await loadSprite('bg.jpg')
      ..size = size;

    add(backgroundImage);

    forceDisplay
      ..anchor = Anchor.topCenter
      ..x = screenWidth / 2
      ..y = screenHeight / 15;
    add(forceDisplay);

    uparm
      ..anchor = Anchor.centerLeft
      ..sprite = await loadSprite('arm.png')
      ..size = Vector2(leverLength, leverWidth)
      ..y = screenHeight - 150
      ..x = 0.05 * screenWidth
      ..angle = minOpenAngle;

    add(uparm);

    downarm
      ..anchor = Anchor.centerLeft
      ..sprite = await loadSprite('arm.png')
      ..size = Vector2(leverLength, leverWidth)
      ..y = screenHeight - 150
      ..x = 0.05 * screenWidth;

    add(downarm);
    downarm.setSnap();

    //arrays containing properties of Suparis
    supariSize = [0.06 * screenWidth, 0.1 * screenWidth, 0.14 * screenWidth];

    //initial llocation of supari on the screen
    supariLoc = [
      Vector2(screenWidth - 50, screenHeight - 250),
      Vector2(screenWidth - 200, screenHeight - 150),
      Vector2(screenWidth - 350, screenHeight - 150)
    ];

    for (int i = 0; i < 3; i++) {
      MyDragSpriteSupari supari = MyDragSpriteSupari()
        ..index = i
        ..anchor = Anchor.bottomCenter
        ..sprite = await loadSprite('supari.png')
        ..size = Vector2(supariSize[i], supariSize[i])
        ..position = supariLoc[i]
        ..crackingForce = 1000 + 500.0 * i;
      suparis.add(supari);
      add(suparis[i]);
    }

    supariNormal = await Sprite.load('supari.png');
    supariCrackedFull = await Sprite.load('supari_full.png');
    supariCrackedhalf = await Sprite.load('supari_half.png');
    supariCrackedquarter = await Sprite.load('supari_quarter.png');
    supariCrackedlittle = await Sprite.load('supari_little.png');
  }

  void computeForce() {
    double touchAngle; //angle at which upper arm touches supari

    if (whichRung == -1 || whichSupari == -1) {
      leverForce = 0.0;
      return;
    }

    touchAngle =
        atan2(suparis[whichSupari].height, whichRung * downarm.snapSeperation);

    double angleDiff = touchAngle - uparm.angle.abs();

    if (angleDiff < 0) {
      leverForce = 0.0;
      return;
    } else {
      leverForce = exp(angleDiff.abs() * 25);
      return;
    }
  }

  void updateForceBoard() {
    computeForce();
    forceDisplay.text = 'Force : ${leverForce.toInt().toString()} N';
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
