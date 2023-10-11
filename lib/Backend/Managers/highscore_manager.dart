import 'package:flutter_application_1/Backend/Enums/Difficulty.dart';
import 'package:flutter_application_1/Backend/Managers/database_manager.dart';

import '../Low Level Classes/highscore_entry.dart';

class HighScoreManager {
  List<HighscoreEntry> highscores = [];
  List<HighscoreEntry> topFive = [];
  late DatabaseManager databaseManager;

  HighScoreManager() {
    // Fetch the highscores from the database
    updateContents();
    findTopFive();
    // databaseManager = DatabaseManager();
  }

  void findTopFive([Difficulty? difficulty]) {
    if (difficulty == null) {
      // If no parameter, just fetch top 5 of ANY difficulty
    } else {
      // If a parameter is given, fetch top five of that
      // difficulty
    }
  }

  void addEntry(HighscoreEntry newEntry) {
    // Add a new entry in its correct place based on time. Once this is done
    // insert the value into the database.
  }

  void updateContents() {
    // Using the database manager, Fetch the highscores
  }
}
