import 'dart:async';

import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/settings.dart';

class GameInformation {
  late int time = 0;
  Timer? timer;
  late int deployedFlags = 0;
  late int flagsToPlace = Settings.easyMines;
  late Difficulty difficulty = Difficulty.easy;
  late List<int> dimensions = Settings.easyDimensions;
  // TODO: Add Highscores

  // Getters to make dimension references easier
  int get width => dimensions[0];
  int get height => dimensions[1];

  GameInformation() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      time++;
    });
  }

  void setDifficulty(Difficulty newDifficulty) {
    difficulty = newDifficulty;

    switch (newDifficulty) {
      // Setup the game information based on the difficulty
      case Difficulty.easy:
        flagsToPlace = Settings.easyMines;
        dimensions = Settings.easyDimensions;
        break;
      case Difficulty.medium:
        flagsToPlace = Settings.mediumMines;
        dimensions = Settings.mediumDimensions;
        break;
      case Difficulty.hard:
        flagsToPlace = Settings.hardMines;
        dimensions = Settings.hardDimensions;
        break;
    }
  }

  void deployFlag() => (deployedFlags < flagsToPlace)
      ? deployedFlags++
      : throw Exception("Too many flags");

  void removeFlag() => (deployedFlags > 0)
      ? deployedFlags--
      : throw Exception("No flags Deployed");

  void stopTimer() {
    timer?.cancel();
  }

  void resetTime() {
    time = 0;
  }
}
