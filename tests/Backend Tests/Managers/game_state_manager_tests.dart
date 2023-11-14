import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Managers/game_state_manager.dart';
import 'package:test/test.dart';

void main() {
  group('Game State Manager, fields', () {
    test('Difficulty is initialized to easy', () {
      GameStateManager test = GameStateManager(Difficulty.easy);

      expect(test.difficulty.toString(), Difficulty.easy.toString());
    });

    test('Game State has a grid', () {
      GameStateManager test = GameStateManager(Difficulty.easy);

      expect(test.currentState.grid, isNotNull);
    });

    test('Game State has a time', () {
      GameStateManager test = GameStateManager(Difficulty.easy);

      expect(test.currentState.time, isNotNull);
    });
  });

  group('Game State Manager, methods', () {
    test('newGameState should generate Game State with easy difficulty', () {
      GameStateManager test = GameStateManager(Difficulty.easy);
      test.newGameState();

      expect(test.difficulty.toString(), Difficulty.easy.toString());
    });

    test(
        'newGameStateWithDifficulty should generate Game State with medium difficulty',
        () {
      GameStateManager test = GameStateManager(Difficulty.easy);
      test.newGameStateWithDifficulty(Difficulty.medium);

      expect(test.difficulty.toString(), Difficulty.medium.toString());
    });
  });
}
