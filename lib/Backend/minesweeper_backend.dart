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

  bool isGameWon() => playingGrid.gameIsWon();

  List<int> getDimensions() => playingGrid.dimensions;

  void takeUserInput(String position, InputType type) {
    switch (type) {
      case InputType.flag:
        playingGrid.placeFlag(position);
        break;
      case InputType.clear:
        playingGrid.revealSquare(position);
        break;
    }
    saveGameState();
    removeSaveState();
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
    // Check if there is already an entry in the database
    if (database.isEmpty) {
      // If there is no entry, create a new one
      database.put(1, stateManager.currentState.toModel());
    } else {
      // If there is an entry, update it
      database.putAt(0, stateManager.currentState.toModel());
    }
  }

  void removeSaveState() {
    // Don't save if the game is over or won
    if (playingGrid.isGameOver || playingGrid.gameIsWon()) {
      // Remove entry from database
      if (database.isNotEmpty) database.deleteAt(0);
    }
  }
}
