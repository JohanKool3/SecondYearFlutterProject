// Static class that is responsible for handling cell inputs

import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:flutter_application_1/Frontend/Widgets/cell_widget.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class CellInputManager {
  static bool illegalInput(CellWidget cell) {
    // Fetch information from Cell
    MinesweeperBackend? backend = cell.backend;
    bool cellPressed = cell.cellPressed;

    bool gameOver = backend!.playingGrid.isGameOver;
    bool gameWon = backend.playingGrid.gameIsWon();

    if (!cellPressed || inputNotAllowed(cell)) {
      return true;
    } else if (gameOver || gameWon) {
      // Game is won or lost
      backend.removeSaveState();
      return true;
    } else {
      // Input is valid
      return false;
    }
  }

  static bool inputNotAllowed(CellWidget cell) {
    bool selected = cell.selected;
    GridContent? content = cell.content;
    Minesweeper game = cell.gameRef;

    return (selected == true || // Cell is already selected
            content!.isFlagged &&
                game.inputType ==
                    InputType
                        .clear) && // Cell is flagged and the input type is not flag
        !chordingPossible(cell);
  }

  static bool chordingPossible(CellWidget cell) {
    GridContent? content = cell.content;
    Minesweeper game = cell.gameRef;
    MinesweeperBackend backend = cell.backend!;

    return (game.inputType == InputType.clear && // Currently Clearing
        content!.isRevealed && // The square is revealed
        backend.playingGrid.getAdjacentFlagCount(content.position) ==
            content.value); // There are sufficient flags around the square
  }
}
