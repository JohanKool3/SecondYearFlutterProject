import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import 'package:flutter_application_1/Frontend/Templates/button.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class IndicatorButtonWidget extends Button with HasGameRef<Minesweeper> {
  IndicatorButtonWidget(Vector2 size, Vector2 newPos, backend)
      : super("", size, newPos, backend);

  @override
  void onLoad() async {
    sprites = [
      await Sprite.load("clearing_trowel.png"),
      await Sprite.load("toggle_flag.png"),
    ];
    sprite = sprites[0];
  }

  @override
  void update(double dt) {
    // Change the sprite based on the input type
    if (game.inputType == InputType.flag) {
      sprite = sprites[1];
    } else {
      sprite = sprites[0];
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Override to do nothing
  }

  @override
  void onTapUp(TapUpEvent event) {
    // Override to do nothing
  }
}
