import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:flutter_application_1/Frontend/Managers/button_manager.dart';
import 'package:flutter_application_1/Frontend/Managers/grid_manager.dart';
import 'package:flutter_application_1/Frontend/Widgets/cell_widget.dart';

class Minesweeper extends FlameGame with HasKeyboardHandlerComponents {
  late MinesweeperBackend backend;

  // Graphical Components
  late GridManager grid;
  late ButtonManager buttons;

  // Positional Components
  Vector2 positionOffset = Vector2(10, 10);
  double cellDimensions = 70;

  Minesweeper(this.backend) {
    // Playing grid
    grid = GridManager(backend, positionOffset, cellDimensions: cellDimensions);

    // Selecting difficulty buttons
    buttons = ButtonManager(backend, grid.bottomLeft,
        Vector2(cellDimensions * 1.5, cellDimensions / 2),
        buttonSpacing: 10);
  }

  @override
  Color backgroundColor() => const Color.fromARGB(255, 17, 204, 73);

  @override
  Future<void> onLoad() async {
    generateGameObjects();
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

  void generateNewGame(Difficulty newDifficulty) {
    backend.setNewDifficulty(newDifficulty);

    // Remove all children
    for (var child in children) {
      if (child is CellWidget) remove(child);
    }

    grid = GridManager(backend, positionOffset, cellDimensions: cellDimensions);
    //Remove all children

    generateGameObjects();
  }

  void generateGameObjects() {
    // Generate game objects here
    // Create an instance of the Components of the game
    addAll(grid.cells);
    addAll(buttons.buttons);
  }
}
