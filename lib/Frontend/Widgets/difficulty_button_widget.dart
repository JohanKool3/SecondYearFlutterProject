import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Frontend/Templates/button.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class DifficultyButtonWidget extends Button with HasGameReference<Minesweeper> {
  DifficultyButtonWidget(Vector2 size, Vector2 newPos, backend, this.difficulty)
      : super(
            (switch (difficulty) {
              Difficulty.easy => "easy",
              Difficulty.medium => "medium",
              Difficulty.hard => "hard",
              _ => throw Exception("Invalid difficulty"),
            }),
            size,
            newPos,
            backend);

  Difficulty? difficulty;

  @override
  void onTapUp(TapUpEvent event) {
    // Change the difficulty to the difficulty of this button
    game.generateNewGame(difficulty!);
    super.onTapUp(event);
  }
}
