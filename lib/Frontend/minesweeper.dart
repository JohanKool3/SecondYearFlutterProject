import 'dart:math';
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
import 'package:flutter_application_1/Frontend/Widgets/flag_amount_widget.dart';
import 'package:flutter_application_1/Frontend/Widgets/timer_box_widget.dart';
import 'package:window_manager/window_manager.dart';

class Minesweeper extends FlameGame with HasKeyboardHandlerComponents {
  late MinesweeperBackend backend;
  // Graphical Components
  late GridManager grid;
  late ButtonManager buttons;
  WindowManager wm = WindowManager.instance;

  bool displayedWonGame = false;

  // Positional Components
  late Vector2 positionOffset;
  double cellDimensions = 57;
  Color currentColor = const Color.fromARGB(255, 17, 204, 73);

  // Logical Components
  InputType inputType = InputType.clear;

  Minesweeper(this.backend) {
    //Setup of the window
    wm.setAspectRatio(1.0); // Set aspect ratio
    positionOffset = Vector2(0, cellDimensions * 2);

    //Manager setup
    grid = GridManager(backend, positionOffset, cellDimensions: cellDimensions);

    buttons = ButtonManager(backend, grid.bottomLeft,
        Vector2(cellDimensions * 1.5, cellDimensions / 2),
        buttonSpacing: 10);
  }

  @override
  Color backgroundColor() => currentColor;

  @override
  Future<void> onLoad() async {
    try {
      _dynamicScaling();
      _resetGUI();
    } catch (e) {
      // When there is concurrent operations, cannot delete children (we must wait)
      return;
    }

    generateGameObjects();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    try {
      if (_newScale() != cellDimensions) {
        // Only resize if there is a need to
        _dynamicScaling();
        _resetGUI();
      }
    } catch (e) {
      // When there is concurrent operations, cannot delete children (we must wait)
      return;
    }
    generateGameObjects();
  }

  @override
  void update(double dt) {
    // Update game logic here
    super.update(dt);
    if (backend.isGameWon()) {
      backend.stopTimer();

      if (!displayedWonGame) {
        _displayWonGame();
      }
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
      } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
        inputType = InputType.flag;

        //Restart Game
      } else if (event.logicalKey == LogicalKeyboardKey.keyR) {
        generateNewGame(backend.information.difficulty);
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void generateNewGame(Difficulty newDifficulty) {
    backend.setNewDifficulty(newDifficulty);
    displayedWonGame = false;
    // Synchronize the time to be 0
    backend.stopTimer();
    backend.setTime(0);

    _resetGUI();
    backend.startTimer();
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
    addAll([
      TimerBoxWidget(Vector2(cellDimensions * 6, cellDimensions),
          Vector2(cellDimensions * 3, cellDimensions), backend),
      FlagAmountWidget(Vector2(cellDimensions * 3, cellDimensions),
          Vector2(cellDimensions * 3, cellDimensions), backend)
    ]);
  }

  void _displayWonGame() {
    // Remove the grid to show the game won screen

    if (!displayedWonGame) {
      displayedWonGame = true;
    }

    for (var child in children) {
      if (child is CellWidget) remove(child);
    }

    add(StaticElement(
        "game_won",
        Vector2(cellDimensions * 9, cellDimensions * 4),
        Vector2(positionOffset.x, cellDimensions * 4.5)));
    backend.returnGameWonStatus();

    // Remove save state
    backend.removeSaveState();
  }

  double _newScale() {
    // Find the minimum of the two, this will be the scaling factor
    double width = size[0];
    double height = size[1];

    // A cell is about 1 / 12 of the screen

    return min(width, height) / 12;
  }

  void _dynamicScaling() {
    // Set the cell dimensions to the cell size
    cellDimensions = _newScale();
    generateGameObjects();
  }

  void _resetGUI() {
    // Remove all children
    for (var child in children) {
      remove(child);
    }

    grid = GridManager(backend, positionOffset, cellDimensions: cellDimensions);

    buttons = ButtonManager(backend, grid.bottomLeft,
        Vector2(cellDimensions * 1.5, cellDimensions / 2),
        buttonSpacing: 10);

    generateGameObjects();
  }
}
