import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/highscore_entry.dart';
import 'package:flutter_application_1/Backend/Managers/high_score_manager.dart';
import 'package:test/test.dart';

void main() {
  group('High Score Manager, fields', () {
    test('High Score Manager, initial hard scores contents should be empty', () {
      HighscoreManager test = HighscoreManager();

      expect(test.hardScores, isEmpty);
    });

    test('High Score Manager, initial medium scores contents should be empty', () {
      HighscoreManager test = HighscoreManager();

      expect(test.mediumScores, isEmpty);
    });

    test('High Score Manager, initial easy scores contents should be empty', () {
      HighscoreManager test = HighscoreManager();

      expect(test.easyScores, isEmpty);
    });
  });

  group('High Score Manager, methods', () {
    test('High Score Manager, addEntry to hard highscores', () {
      HighscoreManager test = HighscoreManager();
      HighscoreEntry entry = HighscoreEntry("Test",Difficulty.hard, 100);

      test.addHighscore(entry);

      expect(test.hardScores, contains(entry));
    });

    // TODO: Implement other method tests here
  });
}
