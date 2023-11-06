import 'dart:math';

import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';

class Grid {
  Map<String, GridContent> contents = {};
  (int, int) dimensions = (0, 0);

  Grid(int width, int height) {
    _setDimensions(width, height);
    _setupContents();
  }

  void setGrid(int width, int height) {
    if ((width, height) != dimensions) {
      _setDimensions(width, height);
    }
    // Setup the grid
    _setupContents();
  }

  void placeFlag(String position) {
    contents[position]?.toggleFlag();
  }

  void revealSquare(String position) {
    contents[position]?.revealSquare();

    // Check the conditions of the game

    // Check if the square is a mine
    if (_checkForMine(position)) {
      // End the game
    }
    _checkForField(position);
  }

  void _checkForField(String position){
    // Check for neighbouring squares which are also empty Only if the current position is also empty
  }

  bool _checkForMine(String position) => contents[position]?.isMine ?? false;

  void _setDimensions(int width, int height) {
    dimensions = (width, height);
  }

  void _setupContents() {
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
    int mineAmount = 40;
    
    // Guard Clause to prevent infinite loops
    if(mineAmount > width * height){
      throw Exception("Too many mines for the grid size");
    }

    while(currentMines != mineAmount){

      int xPos = Random().nextInt(width);
      int yPos = Random().nextInt(height);

      String position = "($xPos, $yPos)";

      if(!contents[position]!.isMine){
        contents[position]!.setMine();
        currentMines++;
      }
    }
  }
}
