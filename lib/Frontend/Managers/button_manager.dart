import 'package:flame/components.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:flutter_application_1/Frontend/Widgets/difficulty_button_widget.dart';
import 'package:flutter_application_1/Frontend/Widgets/utility_button_widget.dart';

class ButtonManager extends PositionComponent {
  List<PositionComponent> buttons = [];
  MinesweeperBackend? backend;
  Vector2 positionOffset = Vector2.zero();
  Vector2 buttonSize;
  double buttonSpacing;

  ButtonManager(this.backend, this.positionOffset, this.buttonSize,
      {this.buttonSpacing = 10}) {
    size = buttonSize;
    _generate();
  }

  void _generate() {
    // Generate the buttons
    Vector2 difference = Vector2(buttonSize.x + buttonSpacing, 0);

    buttons = [
      // Easy button
      DifficultyButtonWidget(
          buttonSize, positionOffset, backend, Difficulty.easy),

      // Medium button
      DifficultyButtonWidget(
          buttonSize, positionOffset + difference, backend, Difficulty.medium),

      // Hard button
      DifficultyButtonWidget(buttonSize, positionOffset + difference * 2,
          backend, Difficulty.hard),

      // Resart button
      UtilityButtonWidget(Vector2(buttonSize.x / 2, buttonSize.y),
          positionOffset + difference * 3, backend, "restart")
    ];
  }
}
