import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import 'package:flutter_application_1/Backend/Managers/Grid.dart';
import 'package:flutter_application_1/Backend/Managers/game_information.dart';
import 'package:flutter_application_1/Backend/Managers/game_state_manager.dart';

class MinesweeperBackend {
  GameInformation information = GameInformation();
  GameStateManager stateManager = GameStateManager(Difficulty.easy);
  Grid get playingGrid => stateManager.currentState.grid;

  MinesweeperBackend();

  void takeUserInput(String position, InputType type) {

    switch(type){
      case InputType.flag:
        playingGrid.placeFlag(position);
        break;
      case InputType.clear:
        playingGrid.revealSquare(position);
        break;
    }

    if(playingGrid.isGameOver){
      // TODO: Give the user a game over screen (front end), handle a reset or change difficulty
    }
  }

  void resetGame() {
    // Set a new Game State
    stateManager.newGameState();
    // Set game information to the initial values
    information = GameInformation();
  }

  void setNewDifficulty(Difficulty difficulty) => information.setDifficulty(difficulty);
}
