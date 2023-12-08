import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:flutter_application_1/Frontend/Managers/button_manager.dart';
import 'package:flutter_application_1/Frontend/Managers/grid_manager.dart';
import 'package:flutter_application_1/Frontend/Templates/static_element.dart';
import 'package:flutter_application_1/Frontend/Widgets/cell_widget.dart';

class Minesweeper extends FlameGame with HasKeyboardHandlerComponents {
  late MinesweeperBackend backend;
  // Graphical Components
  late GridManager grid;
  late ButtonManager buttons;

  // Positional Components
  late Vector2 positionOffset;
  double cellDimensions = 60;
  late Color currentColor;

  // Logical Components
  InputType inputType = InputType.clear;

  Minesweeper(this.backend) {
    // Set the initial color
    currentColor = Color.fromARGB(255, 17, 204, 73);
    // Set the position offset
    positionOffset = Vector2(0, cellDimensions);

    // Playing grid
    grid = GridManager(backend, positionOffset, cellDimensions: cellDimensions);

    // Selecting difficulty buttons
    buttons = ButtonManager(backend, grid.bottomLeft,
        Vector2(cellDimensions * 1.5, cellDimensions / 2),
        buttonSpacing: 10);
  }

  @override
  Color backgroundColor() => currentColor;

  @override
  Future<void> onLoad() async {
    generateGameObjects();
  }

  @override
  void update(double dt) {
    // Update game logic here
    super.update(dt);
    if (backend.isGameWon()) {
      _displayWonGame();
    }
  }

  @override
  void render(Canvas canvas) {
    // Render game graphics here
    super.render(canvas);
  }

  // Take keyboard input, press a for clear, d for flag
  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyA) {
        inputType = InputType.clear;
        // TODO: Graphical update that clear is selected
      } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
        inputType = InputType.flag;
        // TODO: Graphical update that flag is selected
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void generateNewGame(Difficulty newDifficulty) {
    backend.setNewDifficulty(newDifficulty);

    // Remove all children
    for (var child in children) {
      remove(child);
    }

    grid = GridManager(backend, positionOffset, cellDimensions: cellDimensions);

    generateGameObjects();
  }

  void toggleInputType() {
    if (inputType == InputType.clear) {
      inputType = InputType.flag;
    } else {
      inputType = InputType.clear;
    }
  }

  void generateGameObjects() {
    // Generate game objects here
    // Create an instance of the Components of the game
    addAll(grid.cells);
    addAll(buttons.buttons);
    addAll([
      StaticElement("title_card", Vector2(cellDimensions * 9, cellDimensions),
          Vector2(0, 0))
    ]);
  }

  void _displayWonGame() {
    // Remove the grid to show the game won screen

    for (var child in children) {
      if (child is CellWidget) remove(child);
    }

    add(StaticElement(
        "game_won",
        Vector2(cellDimensions * 9, cellDimensions * 4),
        Vector2(positionOffset.x, cellDimensions * 4.5)));

    // Remove save state
    backend.removeSaveState();
  }
}
