import 'package:flutter_application_1/Backend/Database/Models/HighScore/GameState/game_state_model.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import 'package:flutter_application_1/Backend/Managers/grid.dart';
import 'package:flutter_application_1/Backend/Managers/game_information.dart';
import 'package:flutter_application_1/Backend/Managers/game_state_manager.dart';
import 'package:hive/hive.dart';

class MinesweeperBackend {
  GameInformation information = GameInformation();
  late GameStateManager stateManager;
  Grid get playingGrid => stateManager.currentState.grid;
  late Box database;

  MinesweeperBackend(Box databaseIn) {
    database = databaseIn;
    stateManager = GameStateManager(Difficulty.easy, database: database);
  }

  // Returns if the game is running
  bool returnGameState() => !playingGrid.isGameOver;

  void takeUserInput(String position, InputType type) {
    switch (type) {
      case InputType.flag:
        playingGrid.placeFlag(position);
        break;
      case InputType.clear:
        playingGrid.revealSquare(position);
        break;
    }
  }

  void resetGame() {
    // Set a new Game State
    stateManager.newGameState();
    // Set game information to the initial values
    information = GameInformation();
  }

  void setNewDifficulty(Difficulty difficulty) =>
      information.setDifficulty(difficulty);

  void saveGameState() {
    // Save the game state to the database
    database.put(1, stateManager.currentState.toModel());
  }
}
