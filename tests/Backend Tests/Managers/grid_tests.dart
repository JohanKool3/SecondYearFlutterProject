import 'package:flutter_application_1/Backend/Database/game_content_loader.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:flutter_application_1/Backend/Managers/grid.dart';
import 'package:flutter_application_1/Backend/settings.dart';
import 'package:test/test.dart';

void main() {
  group('Grid, fields', () {
    test('Dimensions should be initialized to 16, 16', () {
      final test = Grid(Difficulty.medium);
      expect(test.dimensions, [16, 16]);
    });

    test('Contents should be initialized to have 256 items', () {
      final test = Grid(Difficulty.medium);
      expect(test.contents.length, 256);
    });

    test('Contents should contain 40 mines', () {
      final test = Grid(Difficulty.medium);
      int mineCount = 0;
      test.contents.forEach((key, value) {
        if (value.isMine) {
          mineCount++;
        }
      });
      expect(mineCount, 40);
    });
  });

  group('Grid, methods', () {
    test('Dimensions should be set to 8 by 5', () {
      final test = Grid(Difficulty.medium);
      test.setGridSpecificly(8, 5);
      expect(test.dimensions, [8, 5]);
    });

    test('First item should be a mine', () {
      final test = Grid(Difficulty.easy);
      test.setGridSpecificly(8, 5);
      expect(test.contents["(0, 0)"]?.isMine, true);
    });

    test('First item should be a flag', () {
      final test = Grid(Difficulty.medium);
      test.placeFlag("(0, 0)");
      expect(test.contents["(0, 0)"]?.isFlagged, true);
    });

    test('First item should be revealed', () {
      final test = Grid(Difficulty.medium);
      test.revealSquare("(0, 0)");
      expect(test.contents["(0, 0)"]?.isRevealed, true);
    });

    test('Generate values works as intended', () {
      List<List<String>> rawGrid = [
        ["UMN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"]
      ];

      final test = GameContentLoader.loadContents(Difficulty.easy, rawGrid);

      expect(test.contents["(1, 0)"]?.value, 1);
    });

    test('Position (1, 1) should have a value of 8', () {
      List<List<String>> rawGrid = [
        ["UMN", "UMN", "UMN", "UNN"],
        ["UMN", "UNN", "UMN", "UNN"],
        ["UMN", "UMN", "UMN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"]
      ];

      final test = GameContentLoader.loadContents(Difficulty.easy, rawGrid);

      expect(test.contents["(1, 1)"]?.value, 8);
    });

    test('Grid should contain total value greater than 0', () {
      final test = Grid(Difficulty.easy);
      int total = 0;

      for (GridContent content in test.contents.values) {
        total += content.value;
      }

      expect(total, greaterThan(0));
    });

    test('Grid should be completely revealed', () {
      List<List<String>> rawGrid = [
        ["UNN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UMN", "UNN"],
        ["UNN", "UMN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"]
      ];

      final test = GameContentLoader.loadContents(Difficulty.easy, rawGrid);

      test.revealSquare("(0, 0)");
    });

    test('Unflagged mines should be 1', () {
      List<List<String>> rawGrid = [
        ["UMN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"]
      ];

      final test = GameContentLoader.loadContents(Difficulty.easy, rawGrid);

      expect(test.unFlaggedMines, 1);
    });

    test('Mine amount should be equal to easy mine amount', () {
      final test = Grid(Difficulty.easy);

      expect(test.unFlaggedMines, Settings.easyMines);
    });

    test('Mine amount should be equal to medium mine amount', () {
      final test = Grid(Difficulty.medium);

      expect(test.unFlaggedMines, Settings.mediumMines);
    });

    test('Mine amount should be equal to hard mine amount', () {
      final test = Grid(Difficulty.hard);

      expect(test.unFlaggedMines, Settings.hardMines);
    });

    test('Unflagged mines should be 0', () {
      List<List<String>> rawGrid = [
        ["UMF", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"]
      ];

      final test = GameContentLoader.loadContents(Difficulty.easy, rawGrid);

      expect(test.unFlaggedMines, 0);
    });

    test('Unflagged mines should be 0, after flag is placed', () {
      List<List<String>> rawGrid = [
        ["UMN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"],
        ["UNN", "UNN", "UNN", "UNN"]
      ];

      final test = GameContentLoader.loadContents(Difficulty.easy, rawGrid);
      test.placeFlag("(0, 0)");

      expect(test.unFlaggedMines, 0);
    });
  });
}
