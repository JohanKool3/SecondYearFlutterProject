import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:test/test.dart';

void main() {
  group('Grid Contents, fields', () {
    test('Grid Content should be initilized to a mine', () {
      final test = GridContent(true, " ", false, false);
      expect(test.isMine, true);
    });

    test('Grid Content should be initilized to a flag', () {
      final test = GridContent(false, " ", true, false);
      expect(test.isFlagged, true);
    });

    test('Grid Content should be initilized to revealed', () {
      final test = GridContent(false, " ", false, true);
      expect(test.isRevealed, true);
    });

    test('Grid Content should be initilized to position (1, 1)', () {
      final test = GridContent(false, "(1, 1)", false, false);
      expect(test.position, "(1, 1)");
    });
  });

  group('Grid Contents, Methods', () {
    /// Tests for Toggle Flag
    test('Toggle Flag should make flagged True', () {
      // Arrange
      final test = GridContent(true, " ", false, false);

      // Act
      test.toggleFlag();

      // Assert

      expect(test.isFlagged, true);
    });

    test('Toggle Flag should make flagged False', () {
      // Arrange
      final test = GridContent(true, " ", true, false);
      // Act
      test.toggleFlag();
      // Assert
      expect(test.isFlagged, false);
    });

    // Tests for Reveal Square
    test('Reveal Flag should return True', () {
      // Arrange
      final test = GridContent(false, " ", true, false);

      // Act
      test.revealSquare();

      // Assert
      expect(test.isRevealed, true);
    });
  });
}
