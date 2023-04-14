import 'package:first_app_flutter/lever1.dart';
import 'package:flame/events.dart';
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
  SpriteComponent downarm = SpriteComponent();
  SpriteComponent backgroundImage = SpriteComponent();
  List<MyDragSpriteSupari> suparis = [];
  MyTextBox hellotext = MyTextBox("hello");

  double maxOpenAngle = pi / 5;

  late double screenWidth;
  late double screenHeight;

  late List<Vector2> supariLoc;
  late List<double> supariSize;

  @override
  Future<void> onLoad() async {
    screenWidth = size[0];
    screenHeight = size[1];

    const double leverWidth = 25;
    final double leverLength = screenWidth * 0.5;

    await super.onLoad();

    hellotext
      ..anchor = Anchor.topCenter
      ..x = screenWidth / 2
      ..y = screenHeight / 2;
    add(hellotext);

    backgroundImage
      ..sprite = await loadSprite('bg.jpg')
      ..size = size;

    add(backgroundImage);

    // player = Player()
    //   ..position = size / 2
    //   ..width = 50
    //   ..height = 100
    //   ..anchor = Anchor.centerLeft;

    //  add(player);

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

    //arrays containing properties of Suparis
    supariSize = [0.06 * screenWidth, 0.1 * screenWidth, 0.14 * screenWidth];

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
        ..position = supariLoc[i];
      suparis.add(supari);
      add(suparis[i]);
    }
  }

  //write the physcis in this part
  @override
  void update(double dt) {
    super.update(dt);
    if (uparm.angle < 0) {
      //uparm.angle += dt;
    }
    if (uparm.angle > 0) {
      //uparm.angle = -1.047;
    }
  }
}

class MyDragSpriteSupari extends SpriteComponent
    with CollisionCallbacks, DragCallbacks, HasGameRef<Lever2Game> {
  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
  }

  late int index;
  MyDragSpriteSupari({super.size});

  final _paint = Paint();
  bool _isDragged = false;

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
  }

  void snap() {
    //number of snappable positions on downarm
    int snapNum = 5;
    // distance between two snapping pos
    double snapSeperation = gameRef.downarm.size[0] / snapNum;

    List<Vector2> snappablePositions = [
      Vector2(gameRef.downarm.x + 1 * snapSeperation, gameRef.downarm.y),
      Vector2(gameRef.downarm.x + 2 * snapSeperation, gameRef.downarm.y),
      Vector2(gameRef.downarm.x + 3 * snapSeperation, gameRef.downarm.y),
      Vector2(gameRef.downarm.x + 4 * snapSeperation, gameRef.downarm.y),
      Vector2(gameRef.downarm.x + 5 * snapSeperation, gameRef.downarm.y),
    ];

    var dis = [
      for (var i = 0; i < snappablePositions.length; i++)
        position.distanceTo(snappablePositions[i])
    ];

    var minDistance = dis.reduce(min);
    var minIndex = dis.indexOf(minDistance);

    //used this condition now to dfetermine snap. might need updating
    if (minDistance < snapSeperation) {
      position = snappablePositions[minIndex];
    } else {
      //go back to original location
      position = gameRef.supariLoc[index];
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is ScreenHitbox) {
      //...
    } else if (other is MyDragSpriteLeverArm) {
      print("gotHit");
    }
  }

  // @override
  // void onCollisionEnd(PositionComponent other) {
  //   if (other is ScreenHitbox) {
  //     //...
  //   } else if (other is MyDragSpriteLeverArm) {
  //     print("gotHit");
  //   }
  // }

  // @override
  // void render(Canvas canvas) {
  //   _paint.color = _isDragged ? Colors.red : Colors.white;
  //   canvas.drawRect(size.toRect(), _paint);
  // }
}

class MyDragSpriteLeverArm extends SpriteComponent
    with CollisionCallbacks, DragCallbacks, HasGameRef<Lever2Game> {
  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
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
    angle += 0.01 * delTheta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is ScreenHitbox) {
      //...
    } else if (other is MyDragSpriteSupari) {
      print("hit!!!");
    }
  }

  // @override
  // void onCollisionEnd(PositionComponent other) {
  //   if (other is ScreenHitbox) {
  //     //...
  //   } else if (other is YourOtherComponent) {
  //     //...
  //   }
  // }
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
    color: BasicPalette.white.color,
    fontSize: 40.0,
    shadows: const [
      Shadow(color: Colors.red, offset: Offset(2, 2), blurRadius: 2),
      Shadow(color: Colors.yellow, offset: Offset(4, 4), blurRadius: 4),
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
          textRenderer: _tiny,
          boxConfig: TextBoxConfig(
            maxWidth: 400,
            timePerChar: timePerChar ?? 0.05,
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
