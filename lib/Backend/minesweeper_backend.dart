import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
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

    // Make sure the difficulty is set correctly after database loading
    information.difficulty = stateManager.difficulty;
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
  }

  void resetGame() {
    // Set a new Game State
    stateManager.newGameState();
    // Set game information to the initial values
    information = GameInformation();
  }

  void setNewDifficulty(Difficulty difficulty) {
    information.setDifficulty(difficulty);
    // Set new game state
    stateManager.newGameStateWithDifficulty(difficulty);
    // remove entry from database
    removeSaveState();
  }

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

  void initiateChording(GridContent content) {
    // Get the surrounding squares
    List<String> surroundingSquares =
        playingGrid.generateSurroundingSquares(content.position);

    // Loop through the surrounding squares
    for (String square in surroundingSquares) {
      // Check if the square is already revealed or flagged
      if (!playingGrid.contents[square]!.isRevealed ||
          !playingGrid.contents[square]!.isFlagged) {
        // Reveal the square
        playingGrid.revealSquare(square);
      }
    }
  }
}
