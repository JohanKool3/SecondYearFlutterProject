import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/highscore_entry.dart';
import 'package:test/test.dart';

void main() {
  group('Highscore Entry, fields', () {
    test('difficulty is initialized to easy', () {
      HighscoreEntry test = HighscoreEntry("test", Difficulty.easy, 100);

      expect(test.difficulty.toString(), Difficulty.easy.toString());
    });

    test('player is set to "test" ', () {
      HighscoreEntry test = HighscoreEntry("test", Difficulty.easy, 100);

      expect(test.player, "test");
    });

    test('time is set to 100 ', () {
      HighscoreEntry test = HighscoreEntry("test", Difficulty.easy, 100);

      expect(test.time, 100);
    });
  });
}
