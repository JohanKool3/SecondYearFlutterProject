import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import '../Managers/grid.dart';

class GameState {
  int time = 0; // Time in seconds

  late Grid grid;
  late Difficulty difficulty = Difficulty.easy;

  GameState(this.difficulty, this.time, {Grid? grid}) {
    // Takes Time as a parameter for loading gamestates
    if (grid != null) {
      this.grid = grid;
    } else {
      this.grid = Grid(difficulty);
    }
  }

  void takeInput(InputType type, String position) => switch (type) {
        InputType.clear => grid.revealSquare(position),
        InputType.flag => grid.placeFlag(
            position,
          )
      };

  void initializeGameState(Difficulty difficulty) {
    grid = Grid(difficulty);
    time = 0;
  }

  void importCustomGrid(Grid newGrid) {
    grid = newGrid;
  }
}
