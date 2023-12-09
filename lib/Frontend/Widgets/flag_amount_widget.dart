import 'package:flame/components.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:flutter_application_1/Backend/settings.dart';

class FlagAmountWidget extends TextBoxComponent {
  FlagAmountWidget(Vector2 newPos, Vector2 size, this.backend)
      : super(
          text: "00",
          position: newPos,
          size: size,
          anchor: Anchor.topLeft,
        );

  MinesweeperBackend backend;

  @override
  void update(double dt) {
    super.update(dt);
    _updateText();
  }

  void _updateText() {
    int mineAmount = switch (backend.information.difficulty) {
      Difficulty.easy => Settings.easyMines,
      Difficulty.medium => Settings.mediumMines,
      Difficulty.hard => Settings.hardMines,
    };
    int deployedFlags = backend.information.deployedFlags;
    text = deployedFlags.toString();

    // Add a 0 if the amount of minutes or seconds is less than 10
    String flagAmountString =
        deployedFlags < 10 ? "0$deployedFlags" : deployedFlags.toString();

    // Set the text to the correct format
    text = "Flags: $flagAmountString/${mineAmount.toString()}";
  }
}
