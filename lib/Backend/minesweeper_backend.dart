import 'package:flutter_application_1/Backend/Enums/Difficulty.dart';
import 'package:flutter_application_1/Backend/Managers/Grid.dart';
import 'package:flutter_application_1/Backend/Managers/game_information.dart';

class MinesweeperBackend {
  GameInformation information = GameInformation();

  // TODO: Implement Game State Manager

  late Grid playingGrid;

  MinesweeperBackend() {
    playingGrid = Grid(information.width, information.height);
  }

  void takeUserInput(String position) {}

  void resetGame() {
    // Set a new Grid that is in play

    // Set game information to the initial values
  }

  void setNewDifficulty(Difficulty difficulty) {}
}
