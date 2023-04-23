import 'dart:async';
import 'package:pocket_prayogshala/modules/acid-base/acidbase.dart';
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

    bool filledState;

    (gameRef.overlays.isActive('GameEndWin') ||
            gameRef.overlays.isActive('GameEndLoss'))
        ? filledState = true
        : filledState = false;

    bool buttonPressable;
    (gameRef.liquid.currentAgent != 'water')
        ? buttonPressable = true
        : buttonPressable = false;

    if (hoveredAssetname == 'acidButtonunpressed.png' &&
        !filledState &&
        buttonPressable) {
      if (gameRef.liquid.amountOfAcid > 0) {
        // congrats you selected acid sucessfully
        // prompt
        gameRef.overlays.add('GameEndWin');
      } else {
        //sorry you were wrong
        gameRef.overlays.add('GameEndLoss');
      }
    }
    if (hoveredAssetname == 'basebuttonunpressed.png' &&
        !filledState &&
        buttonPressable) {
      if (gameRef.liquid.amountOfBase > 0) {
        // congrats you selected Base sucessfully
        // prompt
        gameRef.overlays.add('GameEndWin');
      } else {
        //sorry you were wrong
        gameRef.overlays.add('GameEndLoss');
      }
    }
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
