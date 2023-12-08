import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Frontend/Templates/button.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class UtilityButtonWidget extends Button with HasGameReference<Minesweeper> {
  UtilityButtonWidget(Vector2 size, Vector2 newPos, backend, this.utility)
      : super(utility, size, newPos, backend);
  String utility; // Name of the utility

  @override
  void onTapUp(TapUpEvent event) {
    // Call the correct function based on the utility
    switch (utility) {
      case "restart":
        // Restart the game
        game.generateNewGame(backend!.information.difficulty);
        break;
      default:
        throw Exception("Invalid utility");
    }
    super.onTapUp(event);
  }
}
