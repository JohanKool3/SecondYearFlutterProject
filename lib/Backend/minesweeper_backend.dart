import 'package:flutter_application_1/Backend/Database/Models/HighScore/GameState/game_state_model.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:flutter_application_1/Backend/Managers/grid.dart';
import 'package:flutter_application_1/Backend/Managers/game_information.dart';
import 'package:flutter_application_1/Backend/Managers/game_state_manager.dart';
import 'package:flutter_application_1/main.dart';
import 'package:hive/hive.dart';

class MinesweeperBackend {
  GameInformation information = GameInformation();
  late GameStateManager stateManager;
  Grid get playingGrid => stateManager.currentState.grid;
  late Box database;

  MinesweeperBackend(Box databaseIn) {
    database = databaseIn;
    stateManager = GameStateManager(Difficulty.easy,
        database:
            database); // If it is production (not testing) add backend object

    // Make sure the difficulty is set correctly after database loading
    setTime(stateManager.currentState.time); // Synchronize time
    // Determine the amount of flags and add to information object
    information.difficulty = stateManager.difficulty;
    information.deployedFlags = playingGrid.getFlagAmount();
  }

  // Returns if the game is running
  bool returnGameState() => !playingGrid.isGameOver;

  bool isGameWon() => playingGrid.gameIsWon();

  List<int> getDimensions() => playingGrid.dimensions;

  void takeUserInput(String position, InputType type) {
    switch (type) {
      case InputType.flag:
        // Check to see if there is already the max amount of flags
        if (!playingGrid.contents[position]!.isFlagged &&
            (information.deployedFlags >= information.flagsToPlace)) {
          return;
        }
        // Update grid
        playingGrid.placeFlag(position);
        // Update game information
        if (playingGrid.contents[position]!.isFlagged) {
          information.deployFlag();
        } else {
          information.removeFlag();
        }
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
    information.deployedFlags = 0;
  }

  void setNewDifficulty(Difficulty difficulty) {
    information.setDifficulty(difficulty);
    backend.playingGrid.isGameOver = false; // To prevent the game won screen
    // Set new game state
    stateManager.newGameStateWithDifficulty(difficulty);
    // remove entry from database
    removeSaveState();
    information.deployedFlags = 0;
  }

  void saveGameState() {
    // Check if there is already an entry in the database
    setTime(information.time);

    GameStateModel? model = stateManager.currentState.toModel();
    if (database.isEmpty) {
      // If there is no entry, create a new one
      database.put(1, model);
    } else {
      // If there is an entry, update it
      database.putAt(0, model);
    }
  }

  void removeSaveState() {
    // Don't save if the game is over or won
    if (playingGrid.isGameOver || playingGrid.gameIsWon()) {
      // Remove entry from database
      if (database.isNotEmpty) database.deleteAt(0);
    }
  }

  void setTime(int time) {
    information.time = time;
    stateManager.currentState.time = time;
  }

  void stopTimer() {
    information.stopTimer();
  }

  void startTimer() {
    information.startTimer();
  }

  void initiateChording(GridContent content) {
    // Get the surrounding squares
    List<String> surroundingSquares =
        playingGrid.generateSurroundingSquares(content.position);

    // Loop through the surrounding squares
    for (String square in surroundingSquares) {
      // Check if the square is already revealed or flagged
      if (!playingGrid.contents[square]!.isRevealed &&
          !playingGrid.contents[square]!.isFlagged) {
        // Reveal the square
        playingGrid.revealSquare(square);
      }
    }

    // Save state unless a mine has been hit, then delete it
    if (playingGrid.contents[content.position]!.isMine) {
      removeSaveState();
    } else {
      saveGameState();
    }
  }
}
