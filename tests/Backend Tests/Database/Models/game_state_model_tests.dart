import 'package:flutter_application_1/Backend/Database/Models/HighScore/GameState/game_state_model.dart';
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

      expect(() => GameStateModel(1, 4, rawGrid), returnsNormally);
    });

    test('Initialization returns error due to invalid difficulty', () {
      List<List<String>> rawGrid = [
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"]
      ];

      expect(() => GameStateModel(10, 4, rawGrid), throwsException);
    });

    test('Get Game State runs as normal', () {
      List<List<String>> rawGrid = [
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"]
      ];
      GameStateModel test = GameStateModel(1, 4, rawGrid);

      expect(() => test.grid[0][0], returnsNormally);
    });
  });
}
