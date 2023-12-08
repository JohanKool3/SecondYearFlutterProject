import 'package:flame/components.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:flutter_application_1/Frontend/Widgets/difficulty_button_widget.dart';

class ButtonManager extends PositionComponent {
  List<DifficultyButtonWidget> buttons = [];
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

    buttons = [
      // Easy button
      DifficultyButtonWidget(buttonSize, [positionOffset.x, positionOffset.y],
          backend, Difficulty.easy),

      // Medium button
      DifficultyButtonWidget(
          buttonSize,
          [positionOffset.x + buttonSize.x + buttonSpacing, positionOffset.y],
          backend,
          Difficulty.medium),

      // Hard button
      DifficultyButtonWidget(
          buttonSize,
          [
            positionOffset.x + 2 * buttonSize.x + 2 * buttonSpacing,
            positionOffset.y
          ],
          backend,
          Difficulty.hard)
    ];
  }
}
