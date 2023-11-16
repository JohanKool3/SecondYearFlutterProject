import 'package:flutter_application_1/Backend/Database/game_content_loader.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/game_state.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:test/test.dart';

void main() {
  group('Game Content Loader', () {
    test('Make sure that generate tag is working as intended', () {
      // Ensure that during the process, the grid is not modified
      GridContent test = GridContent(true, "(1, 1)", true, false);

      String output = GameContentLoader.generateSquareTag(test);

      expect(output, "UMF");
    });

    test('Grid after load and save should be the same as input', () {
      List<List<String>> rawGrid = [
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"],
        ["RNF", "RNF", "RNF", "RNN"]
      ];

      // Ensure that during the process, the grid is not modified

      GameState state = GameState(Difficulty.medium, 0);
      state.grid = GameContentLoader.loadContents(Difficulty.medium, rawGrid);

      List<List<String>> outputGrid = GameContentLoader.saveContents(state);

      expect(rawGrid, outputGrid);
    });
  });
}
