import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Managers/game_information.dart';
import 'package:flutter_application_1/Backend/settings.dart';
import 'package:test/test.dart';

void main() {
  group('Game Information, fields', () {
    test('Difficulty should be easy', () {
      late GameInformation test = GameInformation();

      // Have to cast to string because comparing enums is buggy
      expect(test.difficulty.toString(), Difficulty.easy.toString());
    });

    test('Dimensions should be easy Dimensions', () {
      late GameInformation test = GameInformation();

      expect(test.dimensions.toString(), Settings.easyDimensions.toString());
    });

    test('Deployed flags should be 0 placed flags', () {
      late GameInformation test = GameInformation();

      expect(test.deployedFlags, 0);
    });

    test('Flags to place should be the easy amount of flags', () {
      late GameInformation test = GameInformation();

      expect(test.flagsToPlace.toInt(), Settings.easyMines.toInt());
    });
  });

  group('Game Information, methods', () {
    test('Difficulty should be medium', () {
      late GameInformation test = GameInformation();
      test.setDifficulty(Difficulty.medium);

      // Have to cast to string because comparing enums is buggy
      expect(test.difficulty.toString(), Difficulty.medium.toString());
    });

    test('Deployed Flags should be 1', () {
      late GameInformation test = GameInformation();
      test.deployFlag();

      expect(test.deployedFlags, 1);
    });

    test('Flags to place should equal the amount of easy mines (10)', () {
      late GameInformation test = GameInformation();
      expect(test.flagsToPlace, Settings.easyMines);
    });

    test('Flags should not exceed 10', () {
      late GameInformation test = GameInformation();

      // Deploy mines
      for (int i = 0; i < Settings.easyMines; i++) {
        test.deployFlag();
      }
      expect(test.deployedFlags, 10);
    });

    test('Time should be 1', () {
      late GameInformation test = GameInformation();
      while (test.time != 1) {}
      expect(test.time, 1);
      test.stopTimer();
    });
  });
}
