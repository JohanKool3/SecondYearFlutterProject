// Static class that is responsible for handling cell inputs

import 'package:flame/components.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:flutter_application_1/Backend/Managers/game_information.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:flutter_application_1/Frontend/Managers/cell_permissions_manager.dart';
import 'package:flutter_application_1/Frontend/Managers/cell_visibility_manager.dart';
import 'package:flutter_application_1/Frontend/Widgets/cell_widget.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class CellInputManager {
  static void takeInput(CellWidget cell) {
    // Fetch information from Cell
    MinesweeperBackend? backend = cell.backend;
    GridContent? content = cell.content;
    Minesweeper game = cell.gameRef;

    // Guard clause to prevent illegal inputs
    if (CellPermissionsManager.illegalInput(cell)) {
      return;
    }

    cell.cellPressed = false;
    // If the cell is revealed, and the input type is clear, and the chording is possible, then chord
    if (CellPermissionsManager.chordingPossible(cell)) {
      backend!.initiateChording(content!);
      return;
    }

    // Toggle flag for the cell
    else if (game.inputType == InputType.flag) {
      _handleFlagging(cell);
    }

    // User has hit a mine, game is over
    else if (content!.isMine) {
      _handleGameOver(cell);
    } else {
      _handleClearing(cell);
    }
  }

  static void _handleFlagging(CellWidget cell) {
    MinesweeperBackend backend = cell.backend!;
    GameInformation information = backend.information;

    bool cellIsFlagged = cell.content!.isFlagged;
    int userPlacedFlags = information.deployedFlags;
    int flagsToPlace = information.flagsToPlace;

    List<Sprite> sprites = cell.sprites;
    String position = cell.content!.position;
    InputType inputType = cell.gameRef.inputType;

    // Check if the user has placed all the flags and is trying to add flags
    if (!cellIsFlagged && (userPlacedFlags >= flagsToPlace)) {
      return;
    }
    cell.sprite = sprites[0];
    backend.takeUserInput(position, inputType);
    return;
  }

  static void _handleClearing(CellWidget cell) {
    MinesweeperBackend backend = cell.backend!;
    String position = cell.content!.position;
    InputType inputType = cell.gameRef.inputType;

    CellVisibilityManager.reveal(cell);
    backend.takeUserInput(position, inputType);
    cell.selected = true;

    return;
  }

  static void _handleGameOver(CellWidget cell) {
    // Fetch information from cell
    List<Sprite> sprites = cell.sprites;
    String position = cell.content!.position;
    InputType inputType = cell.gameRef.inputType;

    // Change to the mine sprite
    cell.sprite = sprites[4];
    cell.selected = true;
    // Logically update
    cell.backend!.takeUserInput(position, inputType);
    return;
  }
}
