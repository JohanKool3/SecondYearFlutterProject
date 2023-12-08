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
  }
}
