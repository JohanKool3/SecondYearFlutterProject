import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Managers/game_information.dart';
import 'package:flutter_application_1/Backend/settings.dart';
import 'package:test/test.dart';

void main() {
  group('Game Information, fields', () {
    test('Game Information should have a default difficulty of easy', () {
      late GameInformation test = GameInformation();

      // Have to cast to string because comparing enums is buggy
      expect(test.difficulty.toString(), Difficulty.easy.toString());
    });

    test('Game Information should have default easy dimensions', () {
      late GameInformation test = GameInformation();

      expect(test.dimensions.toString(), Settings.easyDimensions.toString());
    });

    test('Game Information should have 0 placed flags by default', () {
      late GameInformation test = GameInformation();

      expect(test.deployedFlags, 0);
    });

    test(
        'Game Information should have by default the easy amount of flags to place',
        () {
      late GameInformation test = GameInformation();

      expect(test.flagsToPlace.toInt(), Settings.easyMines.toInt());
    });
  });

  group('Game Information, methods', () {
    test('Game Information should have a default difficulty of medium', () {
      late GameInformation test = GameInformation();
      test.setDifficulty(Difficulty.medium);

      // Have to cast to string because comparing enums is buggy
      expect(test.difficulty.toString(), Difficulty.medium.toString());
    });

    test('Game Information should have 1 deployed Flag', () {
      late GameInformation test = GameInformation();
      test.deployFlag();

      expect(test.deployedFlags, 1);
    });

    test('Game Information should have an error trying to remove a flag', () {
      late GameInformation test = GameInformation();
      expect(() => test.removeFlag(), throwsA(isA<Exception>()));
    });

    test('Game Information should have an error trying to deploy a flag', () {
      late GameInformation test = GameInformation();

      // Deploy mines
      for (int i = 0; i < Settings.easyMines; i++) {
        test.deployFlag();
      }
      expect(() => test.deployFlag(), throwsA(isA<Exception>()));
    });

    // TODO: Make sure this unit test is functioning as intended
    test('Game Information time should be 1', () {
      late GameInformation test = GameInformation();
      while (test.time != 1) {}
      expect(test.time, 1);
      test.stopTimer();
    });
  });
}
