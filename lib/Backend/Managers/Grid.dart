import 'dart:math';

import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:flutter_application_1/Backend/settings.dart';

class Grid {
  Map<String, GridContent> contents = {};
  (int, int) dimensions = (0, 0);

  Grid(Difficulty difficulty) {
    setGrid(difficulty);
  }

  void setGrid(Difficulty difficulty) {
    // Use of switch expressions simplifies method call
    (int, int) dimensions = switch (difficulty) {
      Difficulty.easy => Settings.easyDimensions,
      Difficulty.medium => Settings.mediumDimensions,
      Difficulty.hard => Settings.hardDimensions,
    };
    int width = dimensions.$1;
    int height = dimensions.$2;

    _setDimensions(width, height);

    int mineAmount = switch (difficulty) {
      Difficulty.easy => Settings.easyMines,
      Difficulty.medium => Settings.mediumMines,
      Difficulty.hard => Settings.hardMines,
    };
    // Setup the grid
    _setupContents(mineAmount);
  }

  void setGridSpecificly(int width, int height) {
    // This method is PURELY for testing purposes
    _setDimensions(width, height);
    _setupContents(40);
  }

  void placeFlag(String position) {
    if (_validateInput(position)) {
      contents[position]?.toggleFlag();
    } else {
      throw Exception("Positon is not valid");
    }
  }

  void revealSquare(String position) {
    if (_validateInput(position)) {
      contents[position]?.revealSquare();

      // Check the conditions of the game

      // Check if the square is a mine
      if (_checkForMine(position)) {
        // End the game
      }
      _checkForField(position);
    } else {
      throw Exception("Position is not valid");
    }
  }

  void _checkForField(String position) {
    // Check for neighbouring squares which are also empty Only if the current position is also empty
  }

  bool _checkForMine(String position) => contents[position]?.isMine ?? false;

  void _setDimensions(int width, int height) {
    dimensions = (width, height);
  }

  void _setupContents(int difficultyMines) {
    int width = dimensions.$1;
    int height = dimensions.$2;

    // Setup the grid
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        contents["($i, $j)"] = GridContent(false, "($i, $j)", false, false);
      }
    }

    // Setup the mines
    int currentMines = 0;
    // TODO: Implement a difficulty scaling on mine amount
    int mineAmount = difficultyMines;

    // Guard Clause to prevent infinite loops
    if (mineAmount > width * height) {
      throw Exception("Too many mines for the grid size");
    }

    while (currentMines != mineAmount) {
      int xPos = Random().nextInt(width);
      int yPos = Random().nextInt(height);

      String position = "($xPos, $yPos)";

      if (!contents[position]!.isMine) {
        contents[position]!.setMine();
        currentMines++;
      }
    }
  }

  bool _validateInput(String input) => contents.containsKey(input);
}
