import 'package:flutter_application_1/Backend/Enums/Difficulty.dart';
import 'package:flutter_application_1/Backend/Managers/game_information.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:test/test.dart';

void main() {
  group('Minesweeper Backend', () {
    test('Minesweeper backend should have an initialized game information', () {
      late MinesweeperBackend test = MinesweeperBackend();

      expect(test.information.difficulty, Difficulty.easy);
    });
  });
}