import '../lever2.dart';
import 'package:flame/components.dart';

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
