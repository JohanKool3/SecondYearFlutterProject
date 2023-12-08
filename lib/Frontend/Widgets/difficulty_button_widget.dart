import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';

class DifficultyButtonWidget extends SpriteComponent
    with HoverCallbacks, TapCallbacks {
  DifficultyButtonWidget(
      double size, List<double> newPos, this.backend, this.difficulty)
      : super(size: Vector2.all(size), position: Vector2.array(newPos));

  MinesweeperBackend? backend;
  Difficulty? difficulty;
  List<Sprite> sprites = [];

  @override
  FutureOr<void> onLoad() async {
    // Loading sprites through a switch expression

    _loadSprites(switch (difficulty) {
      Difficulty.easy => "easy",
      Difficulty.medium => "medium",
      Difficulty.hard => "hard",
      _ => throw Exception("Invalid difficulty"),
    });

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
    super.onTapUp(event);
  }

  void _loadSprites(String difficultyName) async {
    sprites = [
      await Sprite.load("${difficultyName}_button.png"),
      await Sprite.load("${difficultyName}_button_hover.png"),
      await Sprite.load("${difficultyName}_button_down.png"),
    ];
  }
}
