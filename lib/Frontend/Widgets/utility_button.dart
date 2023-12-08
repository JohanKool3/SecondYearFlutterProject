import 'package:flame/components.dart';
import 'package:flutter_application_1/Frontend/Templates/button.dart';

class UtilityButton extends Button {
  UtilityButton(Vector2 size, Vector2 newPos, backend, this.utility)
      : super(utility, size, newPos, backend);
  String utility; // Name of the utility

  @override
  void onLoad() async {
    sprites = [
      await Sprite.load("${utility}_button.png"),
      await Sprite.load("${utility}_button_hover.png"),
      await Sprite.load("${utility}_button_down.png"),
    ];
  }
}
