import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import 'package:flutter_application_1/Backend/Managers/grid.dart';
import 'package:flutter_application_1/Backend/Managers/game_information.dart';
import 'package:flutter_application_1/Backend/Managers/game_state_manager.dart';

class MinesweeperBackend {
  GameInformation information = GameInformation();
  GameStateManager stateManager = GameStateManager(Difficulty.easy);
  Grid get playingGrid => stateManager.currentState.grid;

  MinesweeperBackend();

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
}
