import 'package:flutter_application_1/Backend/Database/game_content_loader.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/game_state.dart';
import 'package:flutter_application_1/Backend/Managers/grid.dart';

class GameStateModel {
  int id;
  late Difficulty difficulty;
  late int time;
  late Grid grid;

  GameStateModel(
      this.id, int difficultyValue, this.time, List<List<String>> rawGrid) {
    switch (difficultyValue) {
      case (0):
        difficulty = Difficulty.easy;
        break;

      case (1):
        difficulty = Difficulty.medium;
        break;

      case (2):
        difficulty = Difficulty.hard;
        break;

      default:
        throw Exception("Invalid difficulty value");
    }

    // Map the grid to a grid object
    grid = GameContentLoader.loadContents(difficulty, rawGrid);
  }

  GameState getGameState() {
    return GameState(difficulty, time, grid: grid);
  }
}
