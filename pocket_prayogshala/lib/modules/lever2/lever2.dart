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
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/logo.png'),
        title: Text('Pocket Prayogshala'),
      ),
      body: GameWidget(game: Lever2Game()), //bodyColumn,
    );
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

  late Sprite supariLargeCracked;
  late Sprite supariLarge1;
  late Sprite supariLarge2;
  late Sprite supariLarge3;
  late Sprite supariLarge4;

  late Sprite supariSmallCracked;
  late Sprite supariSmall1;
  late Sprite supariSmall2;
  late Sprite supariSmall3;
  late Sprite supariSmall4;

  late Sprite walnutCracked;
  late Sprite walnut1;
  late Sprite walnut2;
  late Sprite walnut3;
  late Sprite walnut4;

  late List<Vector2> supariLoc;
  late List<double> supariSize;

  double leverForce = 0;

  @override
  Future<void> onLoad() async {
    screenWidth = size[0];
    screenHeight = size[1];

    final double upLeverLength = screenWidth * 0.6;
    final double upLeverWidth = upLeverLength * 0.35;

    final double downLeverLength = screenWidth * 0.6;
    final double downLeverWidth = downLeverLength * 0.25;

    await super.onLoad();
    backgroundImage
      ..sprite = await loadSprite('lever2_bg.jpg')
      ..size = size;

    add(backgroundImage);

    forceDisplay
      ..anchor = Anchor.topCenter
      ..x = screenWidth / 2
      ..y = screenHeight / 15;
    add(forceDisplay);

    uparm
      ..anchor = Anchor.centerLeft
      ..sprite = await loadSprite('upArm.png')
      ..size = Vector2(upLeverLength, upLeverWidth)
      ..y = screenHeight - 155
      ..x = 0.05 * screenWidth
      ..angle = minOpenAngle;

    add(uparm);

    downarm
      ..anchor = Anchor.centerLeft
      ..sprite = await loadSprite('downArm.png')
      ..size = Vector2(downLeverLength, downLeverWidth)
      ..y = screenHeight - 150
      ..x = 0.05 * screenWidth;

    add(downarm);
    downarm.setSnap();

    //arrays containing properties of Suparis
    supariSize = [0.1 * screenWidth, 0.06 * screenWidth, 0.1 * screenWidth];

    //initial llocation of supari on the screen
    supariLoc = [
      Vector2(screenWidth - 50, screenHeight - 250),
      Vector2(screenWidth - 200, screenHeight - 150),
      Vector2(screenWidth - 350, screenHeight - 150)
    ];

    supariLargeCracked = await loadSprite('betelnutcracked.png');
    supariLarge1 = await loadSprite('betelnut1.png');
    supariLarge2 = await loadSprite('betelnut2.png');
    supariLarge3 = await loadSprite('betelnut3.png');
    supariLarge4 = await loadSprite('betelnut4.png');

    MyDragSpriteSupari supariLarge = MyDragSpriteSupari()
      ..index = 2
      ..anchor = Anchor.center
      ..sprite = supariLarge1
      ..size = Vector2(supariSize[2], supariSize[2])
      ..position = supariLoc[2]
      ..crackingForce = 2000
      ..sprite1 = supariLarge1
      ..sprite2 = supariLarge2
      ..sprite3 = supariLarge3
      ..sprite4 = supariLarge4
      ..spritecracked = supariLargeCracked;
    suparis.add(supariLarge);
    add(suparis[0]);

    supariSmallCracked = await loadSprite('betelnutcracked.png');
    supariSmall1 = await loadSprite('betelnut1.png');
    supariSmall2 = await loadSprite('betelnut2.png');
    supariSmall3 = await loadSprite('betelnut3.png');
    supariSmall4 = await loadSprite('betelnut4.png');

    MyDragSpriteSupari supariSmall = MyDragSpriteSupari()
      ..index = 1
      ..anchor = Anchor.center
      ..sprite = supariSmall1
      ..size = Vector2(supariSize[1], supariSize[1])
      ..position = supariLoc[1]
      ..crackingForce = 1500
      ..sprite1 = supariSmall1
      ..sprite2 = supariSmall2
      ..sprite3 = supariSmall3
      ..sprite4 = supariSmall4
      ..spritecracked = supariSmallCracked;
    suparis.add(supariSmall);
    add(suparis[1]);

    walnutCracked = await loadSprite('walnutcracked.png');
    walnut1 = await loadSprite('walnut1.png');
    walnut2 = await loadSprite('walnut2.png');
    walnut3 = await loadSprite('walnut3.png');
    walnut4 = await loadSprite('walnut4.png');

    MyDragSpriteSupari walnut = MyDragSpriteSupari()
      ..index = 0
      ..anchor = Anchor.center
      ..sprite = walnut1
      ..size = Vector2(supariSize[0], supariSize[0])
      ..position = supariLoc[0]
      ..crackingForce = 3000
      ..sprite1 = walnut1
      ..sprite2 = walnut2
      ..sprite3 = walnut3
      ..sprite4 = walnut4
      ..spritecracked = walnutCracked;

    suparis.add(walnut);
    add(suparis[2]);
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
