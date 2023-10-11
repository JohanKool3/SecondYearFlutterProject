import 'package:flutter_application_1/Backend/Enums/Difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/GridContent.dart';
import 'game_information.dart';

class Grid {
  late List<GridContent> contents;
  late var dimensions = (0, 0);
  late GameInformation information;
  late Difficulty difficulty;

  Grid(this.information, this.difficulty);

  void setGrid() {
    // Setup the grid according to the difficulty
  }

  void placeFlag((int, int) position) {
    // Place a flag, with a given input
  }

  void clearCell((int, int) position) {
    // When the player goes to clear a cell.

    // Handle if a mine

    // Handle if a field
  }

  void _checkForField((int, int) position) {
    // Check for a field
  }

  /// Start of the setup region
  void _placeMines(int amount) {
    // Place a set amount of mines, determined by the
    // difficulty
  }

  void _setupGrid(int dimensions) {
    // This will create the blank slate for the grid
  }
}
