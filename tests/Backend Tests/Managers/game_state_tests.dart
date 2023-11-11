import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
import 'package:flutter_application_1/Backend/Managers/Grid.dart';
import 'package:flutter_application_1/Backend/Managers/game_state.dart';
import 'package:test/test.dart';

void main() {
  group('Game State, Fields', () {
    test('Game State should have time 0 on creation', () {
      // Have to cast to string because comparing enums is buggy
      GameState test = GameState(Difficulty.easy, 0);
      expect(test.time, 0);
    });

    test('Game State should have difficulty easy on creation', () {
      // Have to cast to string because comparing enums is buggy
      GameState test = GameState(Difficulty.easy, 0);
      expect(test.difficulty.toString(), Difficulty.easy.toString());
    });

    test('Game State should have a grid on creation', () {
      // Have to cast to string because comparing enums is buggy
      GameState test = GameState(Difficulty.easy, 0);
      expect(test.grid.toString(), Grid(Difficulty.easy).toString());
    });
  });

  group('Game State, Methods', () {
    test('Take Input should returns no Exception', () {
      // Have to cast to string because comparing enums is buggy
      GameState test = GameState(Difficulty.easy, 0);

      expect(
          () => test.takeInput(InputType.clear, ("(0, 0)")), returnsNormally);
    });

    test('Take Input should return an Exception', () {
      // Have to cast to string because comparing enums is buggy
      GameState test = GameState(Difficulty.easy, 0);

      expect(() => test.takeInput(InputType.clear, ("Invalid Input")),
          throwsA(isA<Exception>()));
    });

    test('Initialize Game State returns no Exception', () {
      // Have to cast to string because comparing enums is buggy
      GameState test = GameState(Difficulty.easy, 0);

      expect(
          () => test.initializeGameState(Difficulty.medium), returnsNormally);
    });
  });
}
