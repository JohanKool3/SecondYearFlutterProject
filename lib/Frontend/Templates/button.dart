import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';

class Button extends SpriteComponent with HoverCallbacks, TapCallbacks {
  Button(this.name, Vector2 size, Vector2 newPos, this.backend)
      : super(size: size, position: newPos);

  List<Sprite> sprites = [];
  MinesweeperBackend? backend;
  String name;

  @override
  void onLoad() async {
    sprites = [
      await Sprite.load("${name}_button.png"),
      await Sprite.load("${name}_button_hover.png"),
      await Sprite.load("${name}_button_down.png"),
    ];

    sprite = sprites[0];
  }

  @override
  void onHoverEnter() async {
    sprite = sprites[1];
    super.onHoverEnter();
  }

  @override
  void onHoverExit() async {
    // Change to the normal sprite
    sprite = sprites[0];
    super.onHoverExit();
  }

  @override
  void onTapUp(TapUpEvent event) {
    // Change to the normal sprite
    sprite = sprites[0];
    super.onTapUp(event);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Change to the tap down sprite
    sprite = sprites[2];
    super.onTapDown(event);
  }
}
