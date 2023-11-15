import 'package:flutter_application_1/Backend/Database/game_content_loader.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:flutter_application_1/Backend/Managers/grid.dart';
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
      Grid testGrid =
          GameContentLoader.loadContents(Difficulty.medium, rawGrid);
      List<List<String>> outputGrid = GameContentLoader.saveContents(testGrid);

      expect(rawGrid, outputGrid);
    });
  });
}
