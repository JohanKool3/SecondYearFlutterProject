import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import 'package:flutter_application_1/Frontend/Templates/button.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class UtilityButtonWidget extends Button with HasGameReference<Minesweeper> {
  UtilityButtonWidget(Vector2 size, Vector2 newPos, backend, this.utility)
      : super(utility, size, newPos, backend);
  String utility; // Name of the utility

  @override
  void onLoad() async {
    if (utility != "indicator") {
      super.onLoad();
      return;
    } else {
      // Load the sprites
      sprites = [
        await Sprite.load("clearing_trowel.png"),
        await Sprite.load("toggle_flag.png"),
      ];
      // Set the sprite to the first sprite in the list
      sprite = sprites[0];
    }
  }

  @override
  void update(double dt) {
    if (utility == "indicator") {
      // Change the sprite based on the input type
      if (game.inputType == InputType.flag) {
        sprite = sprites[1];
      } else {
        sprite = sprites[0];
      }
    }
    super.update(dt);
  }

  @override
  void onTapUp(TapUpEvent event) {
    // Call the correct function based on the utility
    switch (utility) {
      case "restart":
        // Restart the game
        game.generateNewGame(backend!.information.difficulty);
        break;

      case "flag":
        // Change the input type to flag
        if (game.inputType == InputType.flag) {
          sprite = sprites[1];
        } else {
          sprite = sprites[0];
        }
        break;
      default:
        throw Exception("Invalid utility");
    }
    super.onTapUp(event);
  }
}
