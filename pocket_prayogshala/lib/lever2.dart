import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:math';
import 'package:flame/experimental.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';

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

    supariCrackedFull = await Sprite.load('supari_full.png');
    supariCrackedhalf = await Sprite.load('supari_half.png');
    supariCrackedquarter = await Sprite.load('supari_quarter.png');
    supariCrackedlittle = await Sprite.load('supari_little.png');
  }

  //write the physcis in this part
  @override
  void update(double dt) {
    super.update(dt);
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
}

class MyDragSpriteSupari extends SpriteComponent
    with CollisionCallbacks, DragCallbacks, HasGameRef<Lever2Game> {
  late double crackingForce;
  bool isOnLever = false;

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
  }

  late int index;
  MyDragSpriteSupari({super.size});

  final _paint = Paint();
  bool _isDragged = false;
  bool isOverLappingArm = false;

  @override
  void onDragStart(DragStartEvent event) => _isDragged = true;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.delta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
    snap();
    if (isOverLappingArm) {
      //go back to original location
      position = gameRef.supariLoc[index];
      isOverLappingArm = false;
    }
  }

  void snap() {
    //number of snappable positions on downarm

    var dis = [
      for (var i = 0; i < gameRef.downarm.snappablePositions.length; i++)
        position.distanceTo(gameRef.downarm.snappablePositions[i])
    ];

    var minDistance = dis.reduce(min);
    var minIndex = dis.indexOf(minDistance);

    //used this condition now to determine snap. might need updating
    if (minDistance < gameRef.downarm.snapSeperation) {
      /*if another supari is already on the lever,
         send it to its place and place new suapri on lever */

      if (gameRef.uparm.containsSupari) {
        gameRef.suparis[gameRef.whichSupari].position =
            gameRef.supariLoc[gameRef.whichSupari];
        gameRef.suparis[gameRef.whichSupari].isOnLever = false;
      }
      gameRef.uparm.containsSupari = true;
      gameRef.whichSupari = index;
      gameRef.suparis[index].isOnLever = true;
      gameRef.whichRung = minIndex;
      position = gameRef.downarm.snappablePositions[minIndex];
    } else {
      //go back to original location
      position = gameRef.supariLoc[index];
      gameRef.suparis[index].isOnLever = false;
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is ScreenHitbox) {
      //...
    } else if (other is MyDragSpriteLeverArm) {
      isOverLappingArm = true;
    }
  }

  @override
  void update(double dt) {
    if (isOnLever) {
      double fratio = crackingForce / gameRef.leverForce;
      if (fratio < 10 && fratio > 5) {
        sprite = gameRef.supariCrackedlittle;
      } else if (fratio <= 5 && fratio > 3) {
        sprite = gameRef.supariCrackedquarter;
      }
      if (fratio <= 3 && fratio > 1) {
        sprite = gameRef.supariCrackedhalf;
      }
      if (fratio <= 1) {
        sprite = gameRef.supariCrackedFull;
      }
    }
  }
}

class MyDragSpriteLeverArm extends SpriteComponent
    with CollisionCallbacks, DragCallbacks, HasGameRef<Lever2Game> {
  late bool containsSupari = false;

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  MyDragSpriteLeverArm({super.size});

  final _paint = Paint();
  bool _isDragged = false;

  @override
  void onDragStart(DragStartEvent event) => _isDragged = true;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // position += event.delta;
    var delTheta = atan2(event.delta[0], event.delta[1]);
    if (angle <= gameRef.maxOpenAngle && angle >= gameRef.minOpenAngle) {
      angle += 0.01 * delTheta;
    }
    gameRef.updateForceBoard();
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
    if (angle >= gameRef.maxOpenAngle) {
      angle = gameRef.maxOpenAngle - 0.01;
    }
    if (angle <= gameRef.minOpenAngle) {
      angle = gameRef.minOpenAngle + 0.01;
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is ScreenHitbox) {
      //...
    } else if (other is MyDragSpriteSupari) {
      //print("hit!!!");
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is ScreenHitbox) {
      //...
    } else if (other is MyDragSpriteSupari) {
      //...
    }
  }
}

class MyNonDragSpriteLeverArm extends SpriteComponent
    with HasGameRef<Lever2Game> {
  MyNonDragSpriteLeverArm({super.size});

  int snapNum = 5;
  // distance between two snapping pos
  late double snapSeperation;

  late List<Vector2> snappablePositions;

  void setSnap() {
    snapSeperation = size[0] / snapNum;
    snappablePositions = [
      Vector2(x + 1 * snapSeperation, y),
      Vector2(x + 2 * snapSeperation, y),
      Vector2(x + 3 * snapSeperation, y),
      Vector2(x + 4 * snapSeperation, y),
    ];
  }
}

final _regularTextStyle =
    TextStyle(fontSize: 18, color: BasicPalette.white.color);
final _regular = TextPaint(style: _regularTextStyle);
final _tiny = TextPaint(style: _regularTextStyle.copyWith(fontSize: 14.0));
final _box = _regular.copyWith(
  (style) => style.copyWith(
    color: Colors.lightGreenAccent,
    fontFamily: 'monospace',
    letterSpacing: 2.0,
  ),
);
final _shaded = TextPaint(
  style: TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 40.0,
    shadows: const [
      Shadow(
          color: Color.fromARGB(255, 244, 250, 65),
          offset: Offset(2, 2),
          blurRadius: 2),
      Shadow(
          color: Color.fromARGB(255, 45, 6, 145),
          offset: Offset(4, 4),
          blurRadius: 4),
    ],
  ),
);

class MyTextBox extends TextBoxComponent {
  MyTextBox(
    String text, {
    super.align,
    super.size,
    double? timePerChar,
    double? margins,
  }) : super(
          text: text,
          textRenderer: _shaded,
          boxConfig: TextBoxConfig(
            maxWidth: 400,
            timePerChar: timePerChar ?? 0.00,
            growingBox: true,
            margins: EdgeInsets.all(margins ?? 25),
          ),
        );

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, width, height);
    canvas.drawRect(rect, Paint()..color = Colors.white10);
    super.render(canvas);
  }
}
