import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Database/Models/highscore_entry.dart';
import 'package:flutter_application_1/Backend/Managers/high_score_manager.dart';
import 'package:test/test.dart';

void main() {
  group('High Score Manager, fields', () {
    test('Initial hard scores contents should be empty', () {
      HighscoreManager test = HighscoreManager();

      expect(test.hardScores, isEmpty);
    });

    test('Initial medium scores contents should be empty', () {
      HighscoreManager test = HighscoreManager();

      expect(test.mediumScores, isEmpty);
    });

    test('Initial easy scores contents should be empty', () {
      HighscoreManager test = HighscoreManager();

      expect(test.easyScores, isEmpty);
    });
  });

  group('High Score Manager, methods', () {
    test('AddEntry to hard highscores', () {
      HighscoreManager test = HighscoreManager();
      HighscoreEntry entry = HighscoreEntry("Test", Difficulty.hard, 100);

      test.addHighscore(entry);

      expect(test.hardScores, contains(entry));
    });

    test('GetHighscores works for easy difficulty', () {
      HighscoreManager test = HighscoreManager();

      List<HighscoreEntry> testData = [
        HighscoreEntry("player1", Difficulty.easy, 1),
        HighscoreEntry("player2", Difficulty.easy, 2),
        HighscoreEntry("player3", Difficulty.easy, 3),
        HighscoreEntry("player4", Difficulty.easy, 4),
        HighscoreEntry("player5", Difficulty.easy, 5),
        HighscoreEntry("player6", Difficulty.medium, 6),
        HighscoreEntry("player7", Difficulty.medium, 7),
        HighscoreEntry("player8", Difficulty.medium, 8),
        HighscoreEntry("player9", Difficulty.medium, 9),
        HighscoreEntry("player10", Difficulty.medium, 10),
        HighscoreEntry("player11", Difficulty.hard, 11),
        HighscoreEntry("player12", Difficulty.hard, 12),
        HighscoreEntry("player13", Difficulty.hard, 13),
        HighscoreEntry("player14", Difficulty.hard, 14),
        HighscoreEntry("player15", Difficulty.hard, 15),
      ];

      for (HighscoreEntry entry in testData) {
        test.addHighscore(entry);
      }

      expect(test.getHighscores(Difficulty.easy, 5).length, 5);
    });

    test('GetHighscores works for medium difficulty', () {
      HighscoreManager test = HighscoreManager();

      List<HighscoreEntry> testData = [
        HighscoreEntry("player1", Difficulty.easy, 1),
        HighscoreEntry("player2", Difficulty.easy, 2),
        HighscoreEntry("player3", Difficulty.easy, 3),
        HighscoreEntry("player4", Difficulty.easy, 4),
        HighscoreEntry("player5", Difficulty.easy, 5),
        HighscoreEntry("player6", Difficulty.medium, 6),
        HighscoreEntry("player7", Difficulty.medium, 7),
        HighscoreEntry("player8", Difficulty.medium, 8),
        HighscoreEntry("player9", Difficulty.medium, 9),
        HighscoreEntry("player10", Difficulty.medium, 10),
        HighscoreEntry("player11", Difficulty.hard, 11),
        HighscoreEntry("player12", Difficulty.hard, 12),
        HighscoreEntry("player13", Difficulty.hard, 13),
        HighscoreEntry("player14", Difficulty.hard, 14),
        HighscoreEntry("player15", Difficulty.hard, 15),
      ];

      for (HighscoreEntry entry in testData) {
        test.addHighscore(entry);
      }

      expect(test.getHighscores(Difficulty.medium, 5).length, 5);
    });

    test('GetHighscores works for hard difficulty', () {
      HighscoreManager test = HighscoreManager();

      List<HighscoreEntry> testData = [
        HighscoreEntry("player1", Difficulty.easy, 1),
        HighscoreEntry("player2", Difficulty.easy, 2),
        HighscoreEntry("player3", Difficulty.easy, 3),
        HighscoreEntry("player4", Difficulty.easy, 4),
        HighscoreEntry("player5", Difficulty.easy, 5),
        HighscoreEntry("player6", Difficulty.medium, 6),
        HighscoreEntry("player7", Difficulty.medium, 7),
        HighscoreEntry("player8", Difficulty.medium, 8),
        HighscoreEntry("player9", Difficulty.medium, 9),
        HighscoreEntry("player10", Difficulty.medium, 10),
        HighscoreEntry("player11", Difficulty.hard, 11),
        HighscoreEntry("player12", Difficulty.hard, 12),
        HighscoreEntry("player13", Difficulty.hard, 13),
        HighscoreEntry("player14", Difficulty.hard, 14),
        HighscoreEntry("player15", Difficulty.hard, 15),
      ];

      for (HighscoreEntry entry in testData) {
        test.addHighscore(entry);
      }

      expect(test.getHighscores(Difficulty.hard, 5).length, 5);
    });

    test('Highscores are being sorted correctly, easy', () {
      HighscoreManager test = HighscoreManager();

      List<HighscoreEntry> testData = [
        HighscoreEntry("player1", Difficulty.easy, 1),
        HighscoreEntry("player2", Difficulty.easy, 2),
        HighscoreEntry("player3", Difficulty.easy, 3),
        HighscoreEntry("player4", Difficulty.easy, 4),
        HighscoreEntry("player5", Difficulty.easy, 5),
        HighscoreEntry("player6", Difficulty.medium, 6),
        HighscoreEntry("player7", Difficulty.medium, 7),
        HighscoreEntry("player8", Difficulty.medium, 8),
        HighscoreEntry("player9", Difficulty.medium, 9),
        HighscoreEntry("player10", Difficulty.medium, 10),
        HighscoreEntry("player11", Difficulty.hard, 11),
        HighscoreEntry("player12", Difficulty.hard, 12),
        HighscoreEntry("player13", Difficulty.hard, 13),
        HighscoreEntry("player14", Difficulty.hard, 14),
        HighscoreEntry("player15", Difficulty.hard, 15),
      ];

      for (HighscoreEntry entry in testData) {
        test.addHighscore(entry);
      }

      expect(test.getHighscores(Difficulty.easy, 5).first, testData[0]);
    });

    test('Highscores are being sorted correctly, medium', () {
      HighscoreManager test = HighscoreManager();

      List<HighscoreEntry> testData = [
        HighscoreEntry("player1", Difficulty.easy, 1),
        HighscoreEntry("player2", Difficulty.easy, 2),
        HighscoreEntry("player3", Difficulty.easy, 3),
        HighscoreEntry("player4", Difficulty.easy, 4),
        HighscoreEntry("player5", Difficulty.easy, 5),
        HighscoreEntry("player6", Difficulty.medium, 6),
        HighscoreEntry("player7", Difficulty.medium, 7),
        HighscoreEntry("player8", Difficulty.medium, 8),
        HighscoreEntry("player9", Difficulty.medium, 9),
        HighscoreEntry("player10", Difficulty.medium, 10),
        HighscoreEntry("player11", Difficulty.hard, 11),
        HighscoreEntry("player12", Difficulty.hard, 12),
        HighscoreEntry("player13", Difficulty.hard, 13),
        HighscoreEntry("player14", Difficulty.hard, 14),
        HighscoreEntry("player15", Difficulty.hard, 15),
      ];

      for (HighscoreEntry entry in testData) {
        test.addHighscore(entry);
      }

      expect(test.getHighscores(Difficulty.medium, 5).first, testData[5]);
    });

    test('Highscores are being sorted correctly, hard', () {
      HighscoreManager test = HighscoreManager();

      List<HighscoreEntry> testData = [
        HighscoreEntry("player1", Difficulty.easy, 1),
        HighscoreEntry("player2", Difficulty.easy, 2),
        HighscoreEntry("player3", Difficulty.easy, 3),
        HighscoreEntry("player4", Difficulty.easy, 4),
        HighscoreEntry("player5", Difficulty.easy, 5),
        HighscoreEntry("player6", Difficulty.medium, 6),
        HighscoreEntry("player7", Difficulty.medium, 7),
        HighscoreEntry("player8", Difficulty.medium, 8),
        HighscoreEntry("player9", Difficulty.medium, 9),
        HighscoreEntry("player10", Difficulty.medium, 10),
        HighscoreEntry("player11", Difficulty.hard, 11),
        HighscoreEntry("player12", Difficulty.hard, 12),
        HighscoreEntry("player13", Difficulty.hard, 13),
        HighscoreEntry("player14", Difficulty.hard, 14),
        HighscoreEntry("player15", Difficulty.hard, 15),
      ];

      for (HighscoreEntry entry in testData) {
        test.addHighscore(entry);
      }

      expect(test.getHighscores(Difficulty.hard, 5).first, testData[10]);
    });

    test('Highscores returns error when out of range', () {
      HighscoreManager test = HighscoreManager();

      List<HighscoreEntry> testData = [
        HighscoreEntry("player1", Difficulty.easy, 1),
        HighscoreEntry("player2", Difficulty.easy, 2),
        HighscoreEntry("player3", Difficulty.easy, 3),
        HighscoreEntry("player4", Difficulty.easy, 4),
        HighscoreEntry("player5", Difficulty.easy, 5),
        HighscoreEntry("player6", Difficulty.medium, 6),
        HighscoreEntry("player7", Difficulty.medium, 7),
        HighscoreEntry("player8", Difficulty.medium, 8),
        HighscoreEntry("player9", Difficulty.medium, 9),
        HighscoreEntry("player10", Difficulty.medium, 10),
        HighscoreEntry("player11", Difficulty.hard, 11),
        HighscoreEntry("player12", Difficulty.hard, 12),
        HighscoreEntry("player13", Difficulty.hard, 13),
        HighscoreEntry("player14", Difficulty.hard, 14),
        HighscoreEntry("player15", Difficulty.hard, 15),
      ];

      for (HighscoreEntry entry in testData) {
        test.addHighscore(entry);
      }

      expect(() => test.getHighscores(Difficulty.easy, 10),
          throwsA(isA<Exception>()));
    });
  });
}
