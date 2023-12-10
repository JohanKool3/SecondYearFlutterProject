import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/highscore_entry.dart';

class HighscoreManager {
  // Highscores for each difficulty
  late List<HighscoreEntry> hardScores;
  late List<HighscoreEntry> mediumScores;
  late List<HighscoreEntry> easyScores;

  HighscoreManager() {
    hardScores = [];
    mediumScores = [];
    easyScores = [];
  }

  Iterable<HighscoreEntry> getHighscores(Difficulty difficulty, int range) {
    if (range < 0) {
      throw Exception("Range cannot be negative");
    }

    switch (difficulty) {
      case Difficulty.easy:
        return _returnEasyScores(range);
      case Difficulty.medium:
        return _returnMediumScores(range);
      case Difficulty.hard:
        return _returnHardScores(range);
    }
  }

  void addHighscore(HighscoreEntry entry) {
    switch (entry.difficulty) {
      case Difficulty.easy:
        easyScores.add(entry);
        easyScores.sort((a, b) => a.time.compareTo(b.time));
        break;
      case Difficulty.medium:
        mediumScores.add(entry);
        mediumScores.sort((a, b) => a.time.compareTo(b.time));
        break;
      case Difficulty.hard:
        hardScores.add(entry);
        hardScores.sort((a, b) => a.time.compareTo(b.time));
        break;
    }
  }

  void importTestData(List<HighscoreEntry> testData) {
    for (HighscoreEntry entry in testData) {
      addHighscore(entry);
    }
  }

  Iterable<HighscoreEntry> _returnEasyScores(int range) {
    if (range > easyScores.length) {
      throw Exception("Range cannot be greater than the number of scores");
    } else {
      return easyScores.getRange(0, range);
    }
  }

  Iterable<HighscoreEntry> _returnMediumScores(int range) {
    if (range > mediumScores.length) {
      throw Exception("Range cannot be greater than the number of scores");
    } else {
      return mediumScores.getRange(0, range);
    }
  }

  Iterable<HighscoreEntry> _returnHardScores(int range) {
    if (range > hardScores.length) {
      throw Exception("Range cannot be greater than the number of scores");
    } else {
      return hardScores.getRange(0, range);
    }
  }
}
