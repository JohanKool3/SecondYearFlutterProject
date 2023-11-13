import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Managers/Grid.dart';
import 'package:test/test.dart';

void main() {
  group('Grid, fields', () {
    test('Grid Dimensions should be initialized to 16, 16', () {
      final test = Grid(Difficulty.medium);
      expect(test.dimensions, (16, 16));
    });

    test('Grid Contents should be initialized to have 256 items', () {
      final test = Grid(Difficulty.medium);
      expect(test.contents.length, 256);
    });

    test('Grid Contents should contain 40 mines', () {
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
    test('Grid should be set to 8 by 5', () {
      final test = Grid(Difficulty.medium);
      test.setGridSpecificly(8, 5);
      expect(test.dimensions, (8, 5));
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
  });
}