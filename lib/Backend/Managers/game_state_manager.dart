import 'package:flutter_application_1/Backend/Database/Models/HighScore/GameState/game_state_model.dart';
import 'package:flutter_application_1/Backend/Database/game_content_loader.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/game_state.dart';
import 'package:flutter_application_1/Backend/Managers/grid.dart';
import 'package:hive/hive.dart';

class GameStateManager {
  late GameState currentState;
  Difficulty difficulty = Difficulty.easy;

  GameStateManager(this.difficulty, {Box? database}) {
    //Try to load first! If you cant load then generate a new one
    if (!loadGameState(database)) {
      newGameState();
    }
  }

  void newGameState() {
    currentState = GameState(difficulty, 0);
  }

  void newGameStateWithDifficulty(Difficulty newDifficulty) {
    setNewDifficulty(newDifficulty);
    currentState = GameState(newDifficulty, 0);
  }

  void setNewDifficulty(Difficulty newDifficulty) => difficulty = newDifficulty;

  bool loadGameState(Box? database) {
    // For Testing
    if (database == null) {
      return false;
    }

    // Fetch a save state from the database
    try {
      // Fetch the model from the database
      GameStateModel model = database.get(1);

      // Map the difficulty
      difficulty = Difficulty.values[model.difficultyId];
      Grid grid = GameContentLoader.loadContents(difficulty, model.grid);

      // Convert to game state
      GameState state = GameState(difficulty, model.time, grid: grid);
      // Set game state
      currentState = state;

      // _debugPrint(state);
      return true;
      // No save state has been found, return false
    } catch (e) {
      return false;
    }
  }

  void saveGameState(Box database) {
    // Save the game state to the database

    database.put(1, currentState.toModel());
  }

  void _debugPrint(GameState state) {
    // Useful for debugging Database issues
    List<List<String>> gridList = GameContentLoader.saveContents(state);

    int width = gridList.length;
    int height = gridList[0].length;

    for (int row = 0; row < width; row++) {
      String rowString = "[";
      for (int column = 0; column < height; column++) {
        String item = gridList[row][column];

        rowString += "$item,";
      }
      print("$rowString]");
    }
  }
}
