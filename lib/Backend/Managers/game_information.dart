import 'package:flutter_application_1/Backend/Enums/difficulty.dart';

class GameInformation{

  // TODO: Add time

  late int  deployedFlags = 0;
  late int flagsToPlace = 0;
  late Difficulty difficulty = Difficulty.easy;
  // TODO: Add Highscores

  void setDifficulty(Difficulty difficulty){
    this.difficulty = difficulty;

    switch(difficulty){
      case Difficulty.easy:
        flagsToPlace = 10;
        break;
      case Difficulty.medium:
        flagsToPlace = 40;
        break;
      case Difficulty.hard:
        flagsToPlace = 99;
        break;
    }
  }

  void deployFlag(){
    deployedFlags++;
  }

  void removeFlag(){
    deployedFlags--;
  }

  void incrementTime(){
    // TODO: Implement time
  }
}