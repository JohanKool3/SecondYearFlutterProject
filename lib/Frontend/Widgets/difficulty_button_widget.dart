import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Frontend/Templates/button.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class DifficultyButtonWidget extends Button with HasGameReference<Minesweeper> {
  DifficultyButtonWidget(
      Vector2 size, List<double> newPos, backend, this.difficulty)
      : super(size, newPos, backend);

  Difficulty? difficulty;
  List<Sprite> sprites = [];

  @override
  FutureOr<void> onLoad() async {
    // Fetch the name of the difficulty for import
    String difficultyName = (switch (difficulty) {
      Difficulty.easy => "easy",
      Difficulty.medium => "medium",
      Difficulty.hard => "hard",
      _ => throw Exception("Invalid difficulty"),
    });

    // Load the correct sprites
    sprites = [
      await Sprite.load("${difficultyName}_button.png"),
      await Sprite.load("${difficultyName}_button_hover.png"),
      await Sprite.load("${difficultyName}_button_down.png"),
    ];

    // Set the sprite to the normal sprite
    sprite = sprites[0];
    return super.onLoad();
  }

  @override
  onHoverEnter() async {
    sprite = sprites[1];
  }

  @override
  onHoverExit() async {
    // Change to the normal sprite
    sprite = sprites[0];
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Change to the tap down sprite
    sprite = sprites[2];
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    // Change to the normal sprite
    // Change the difficulty to the difficulty of this button
    sprite = sprites[0];
    game.generateNewGame(difficulty!);
    super.onTapUp(event);
  }
}
