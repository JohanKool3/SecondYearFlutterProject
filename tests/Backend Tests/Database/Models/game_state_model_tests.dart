import 'package:flutter_application_1/Backend/Database/Models/game_state_model.dart';
import 'package:flutter_application_1/Backend/Managers/grid.dart';
import 'package:test/test.dart';

void main() {
  group('Game State Model, tests', () {
    test('Initialization runs as normal', () {
      List<List<String>> rawGrid = [
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"]
      ];

      expect(() => GameStateModel(1, 1, 4, rawGrid), returnsNormally);
    });

    test('Initialization returns error due to invalid difficulty', () {
      List<List<String>> rawGrid = [
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"]
      ];

      expect(() => GameStateModel(1, 10, 4, rawGrid), throwsException);
    });

    test('Get Game State runs as normal', () {
      List<List<String>> rawGrid = [
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"]
      ];
      GameStateModel test = GameStateModel(1, 1, 4, rawGrid);

      expect(() => test.getGameState(), returnsNormally);
    });

    test('Get Game State returns a mine in position (0, 0)', () {
      List<List<String>> rawGrid = [
        ["UMF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["UNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"]
      ];
      GameStateModel test = GameStateModel(1, 1, 4, rawGrid);
      Grid testGrid = test.getGameState().grid;

      expect(testGrid.contents["(0, 0)"]!.isMine, true);
    });

    test('Get Game State returns unrevealed in position (0, 0)', () {
      List<List<String>> rawGrid = [
        ["UMF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["UNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"]
      ];
      GameStateModel test = GameStateModel(1, 1, 4, rawGrid);
      Grid testGrid = test.getGameState().grid;

      expect(testGrid.contents["(0, 0)"]!.isRevealed, false);
    });

    test('Get Game State returns unrevealed in position (1, 1)', () {
      List<List<String>> rawGrid = [
        ["UMF", "RNF", "RNF", "RNN"],
        ["RNF", "RNN", "RNF", "RNN"],
        ["UNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"]
      ];
      GameStateModel test = GameStateModel(1, 1, 4, rawGrid);
      Grid testGrid = test.getGameState().grid;

      expect(testGrid.contents["(1, 1)"]!.isFlagged, false);
    });
  });
}
