import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';

class Minesweeper extends FlameGame {
  late MinesweeperBackend backend;
  Minesweeper(this.backend);

  @override
  Future<void> onLoad() async {
    // Create an instance of the Components of the game

    addAll([]);
  }

  @override
  void update(double dt) {
    // Update game logic here
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // Render game graphics here
    super.render(canvas);
  }

  void generateGameObjects() {
    // Generate game objects here
  }
}
