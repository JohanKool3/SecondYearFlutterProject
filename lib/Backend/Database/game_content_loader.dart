import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
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

        outputGrid.contents["($row, $column)"] =
            GridContent(isMine, "($row, $column)", isFlagged, isRevealed);
      }
    }

    return outputGrid;
  }

  static List<List<String>> saveContents(Grid grid) {
    List<List<String>> outputGrid = [];

    for (int i = 0; i < grid.dimensions.$1; i++) {
      List<String> row = [];

      for (int j = 0; j < grid.dimensions.$2; j++) {
        String squareTag = generateSquareTag(grid.contents["($i, $j)"]!);
        row.add(squareTag);
      }
      outputGrid.add(row);
    }

    // TODO: Save the grid and information to the database, when DB is implemented
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
