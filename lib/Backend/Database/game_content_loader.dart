import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/game_state.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:flutter_application_1/Backend/Managers/grid.dart';

class GameContentLoader {
  static Grid loadContents(Difficulty difficulty, List<List<String>> rawGrid) {
    int width = rawGrid.length;
    int height = rawGrid[0].length;

    Grid outputGrid = Grid(difficulty);
    // Set the dimensions immediately to prevent errors. Initialize to no mines
    // as mines should already have been calculated before and will be placed
    outputGrid.setGridSpecificly(width, height, mineAmount: 0);

    for (int row = 0; row < width; row++) {
      for (int column = 0; column < height; column++) {
        String item = rawGrid[row][column];

        bool isMine = _detectIsmine(item);
        bool isRevealed = _detectIsRevealed(item);
        bool isFlagged = _detectIsFlagged(item);

        outputGrid.contents["($column, $row)"] =
            GridContent(isMine, "($column, $row)", isFlagged, isRevealed);
      }
    }
    outputGrid.setupValues();
    int mineAmount = outputGrid.getMineAmount();
    int flaggedMines = outputGrid.getFlaggedMineAmount();

    outputGrid.unFlaggedMines = mineAmount - flaggedMines;

    return outputGrid;
  }

  static List<List<String>> saveContents(GameState gameState) {
    List<List<String>> outputGrid = [];
    Grid grid = gameState.grid;

    for (int yRow = 0; yRow < grid.dimensions[0]; yRow++) {
      List<String> row = [];

      for (int column = 0; column < grid.dimensions[1]; column++) {
        String squareTag =
            generateSquareTag(grid.contents["($column, $yRow)"]!);
        row.add(squareTag);
      }
      outputGrid.add(row);
    }

    return outputGrid;
  }

  // Convert from a string to a GridContent object
  static bool _detectIsRevealed(String squareTag) => squareTag[0] == "R";

  static bool _detectIsmine(String squareTag) => squareTag[1] == "M";

  static bool _detectIsFlagged(String squareTag) => squareTag[2] == "F";

  static String generateSquareTag(GridContent input) {
    String output = "";

    if (input.isRevealed) {
      output += "R";
    } else {
      output += "U";
    }

    if (input.isMine) {
      output += "M";
    } else {
      output += "N";
    }

    if (input.isFlagged) {
      output += "F";
    } else {
      output += "N";
    }

    return output;
  }
}
