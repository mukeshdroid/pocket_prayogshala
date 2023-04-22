import 'dart:async';
import 'package:first_app_flutter/modules/acid-base/acidbase.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class TapButton extends SpriteComponent
    with TapCallbacks, HasGameRef<AcidBaseCheckGame> {
  // late double ;
  String? text;
  late Sprite hoveredSprite;
  late Sprite nothoveredSprite;
  String? hoveredAssetname;
  String? nothoveredAssetname;
  Vector2? assignedSize;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    hoveredSprite = await Sprite.load(hoveredAssetname ?? 'bg.jpg');
    nothoveredSprite = await Sprite.load(nothoveredAssetname ?? 'bg.jpg');
    sprite = await hoveredSprite;
    size =
        assignedSize ?? Vector2(gameRef.size[0] * 0.3, gameRef.size[1] * 0.1);
  }

  @override
  void onTapUp(TapUpEvent event) {
    sprite = hoveredSprite;
    size =
        assignedSize ?? Vector2(gameRef.size[0] * 0.3, gameRef.size[1] * 0.1);
    // Do something in response to a tap event
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    // TODO: implement onTapDown
    sprite = nothoveredSprite;
    //specific to the parent
    gameRef.pipett.full = false;
    size =
        assignedSize ?? Vector2(gameRef.size[0] * 0.3, gameRef.size[1] * 0.1);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    sprite = hoveredSprite;
    size =
        assignedSize ?? Vector2(gameRef.size[0] * 0.3, gameRef.size[1] * 0.1);
    // Do something in response to a tap event
  }
}
