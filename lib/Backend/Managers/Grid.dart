import 'dart:math';

import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:flutter_application_1/Backend/settings.dart';

class Grid {
  Map<String, GridContent> contents = {};
  List<int> dimensions = [0, 0];
  bool isGameOver = false;
  late int unFlaggedMines = 0; // How many mines have been correctly flagged

  Grid(Difficulty difficulty) {
    setGrid(difficulty);
  }

  // TODO: Work on this method to ensure that it doesn't break the rules
  bool gameIsWon() => unFlaggedMines == 0 && !isGameOver;

  void setGrid(Difficulty difficulty) {
    // Use of switch expressions simplifies method call
    List<int> dimensions = switch (difficulty) {
      Difficulty.easy => Settings.easyDimensions,
      Difficulty.medium => Settings.mediumDimensions,
      Difficulty.hard => Settings.hardDimensions,
    };
    int width = dimensions[0];
    int height = dimensions[1];

    _setDimensions(width, height);

    int mineAmount = switch (difficulty) {
      Difficulty.easy => Settings.easyMines,
      Difficulty.medium => Settings.mediumMines,
      Difficulty.hard => Settings.hardMines,
    };
    // Setup the grid
    _setupContents(mineAmount);
    unFlaggedMines = mineAmount;
  }

  void setGridSpecificly(int width, int height, {int mineAmount = 40}) {
    // This method is PURELY for testing purposes
    _setDimensions(width, height);

    // Dynamically change mine amount via a parameter
    _setupContents(mineAmount);
  }

  void placeFlag(String position) {
    if (_validateInput(position)) {
      contents[position]?.toggleFlag();

      // Check if the square is a mine
      if (_checkForMine(position)) {
        unFlaggedMines--;
      }
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
        isGameOver = true;
      }
      _checkForField(position);
    } else {
      throw Exception("Position is not valid");
    }
  }

  void _checkForField(String position) {
    // Check for neighbouring squares which are also empty Only if the current position is also empty

    if (contents[position]?.value == 0) {
      // Generate the surrounding squares
      List<String> surroundingSquares =
          generateSurroundingSquares(position).toList();

      // Loop through the surrounding squares
      for (String square in surroundingSquares) {
        // Check if the square is already revealed
        if (!contents[square]!.isRevealed) {
          // Reveal the square
          revealSquare(square);
        }
      }
    }
  }

  bool _checkForMine(String position) => contents[position]?.isMine ?? false;

  void _setDimensions(int width, int height) {
    dimensions = [width, height];
  }

  void _setupContents(int difficultyMines) {
    contents = {};

    int width = dimensions[0];
    int height = dimensions[1];

    // Setup the grid
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        contents["($i, $j)"] = GridContent(false, "($i, $j)", false, false);
      }
    }

    // Setup the mines
    int currentMines = 0;
    // Checks for custom mine amounts that are used for TESTING
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

    // Setup the values
    setupValues();
  }

  bool _validateInput(String input) => contents.containsKey(input);

  int getMineAmount() {
    int mineAmount = 0;

    for (GridContent item in contents.values) {
      if (item.isMine) {
        mineAmount++;
      }
    }

    return mineAmount;
  }

  int getFlaggedMineAmount() {
    int flagAmount = 0;

    for (GridContent item in contents.values) {
      if (item.isFlagged && item.isMine) {
        flagAmount++;
      }
    }

    return flagAmount;
  }

  void setupValues() {
    // Setup the values of the grid

    // Loop through the grid
    for (GridContent content in contents.values) {
      // Check for mines

      // Find position
      String position = content.position;

      if (!content.isMine) {
        for (String surroundingSquare in generateSurroundingSquares(position)) {
          // If the square is invalid, it'll be null (therefore return false)
          if (contents[surroundingSquare]?.isMine ?? false) {
            // Increment the value of the surrounding squares
            content.incrementValue();
          }
        }
      }
    }
  }

  List<String> generateSurroundingSquares(String position) {
    List<String> surroundingSquares = [];
    int x = int.parse(position.substring(1, position.indexOf(",")));
    int y = int.parse(
        position.substring(position.indexOf(",") + 2, position.length - 1));

    List<List<int>> directions = [
      [1, 0], // Right
      [1, 1], // Up Right
      [0, 1], // Up
      [-1, 1], // Down Right
      [-1, 0], // Right
      [-1, -1], // Down Left
      [0, -1], // Down
      [1, -1] // Up Left
    ];

    for (List<int> direction in directions) {
      String position = "(${x + direction[0]}, ${y + direction[1]})";

      if (_validateInput(position)) {
        surroundingSquares.add(position);
      }
    }
    return surroundingSquares;
  }

  int getAdjacentFlagCount(String position) =>
      // Linq esque statement to get the amount of flagged squares
      generateSurroundingSquares(position)
          .where((element) => contents[element]?.isFlagged ?? false)
          .length;
}
