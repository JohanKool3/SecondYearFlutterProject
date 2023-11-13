import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/highscore_entry.dart';

class HighscoreManager{


  // Highscores for each difficulty
  late List<HighscoreEntry> hardScores;
  late List<HighscoreEntry> mediumScores;
  late List<HighscoreEntry> easyScores;

  HighscoreManager(){
    hardScores = [];
    mediumScores = [];
    easyScores = [];
  }

  Iterable<HighscoreEntry> getHighscores(Difficulty difficulty, int range){

    if(range < 0){
      throw Exception("Range cannot be negative");
    }

    switch(difficulty){
      case Difficulty.easy:
        return easyScores.getRange(0, range);
      case Difficulty.medium:
        return mediumScores.getRange(0, range);
      case Difficulty.hard:
        return hardScores.getRange(0, range);
    }
  }

  void addHighscore(HighscoreEntry entry){
    switch(entry.difficulty){
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

  void saveContents(){
    // TODO: Integrate with database manager
  }

  void importContents(){
    // TODO: Integrate with database manager
  }

  void importTestData(List<HighscoreEntry> testData){

    for(HighscoreEntry entry in testData){
      addHighscore(entry);
    }
  }

}