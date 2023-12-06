import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:flutter_application_1/Frontend/Widgets/cell_widget.dart';

class Minesweeper extends FlameGame with HasKeyboardHandlerComponents {
  late MinesweeperBackend backend;
  Minesweeper(this.backend);

  @override
  Color backgroundColor() => const Color.fromARGB(255, 17, 204, 73);

  @override
  Future<void> onLoad() async {
    generateGameObjects();
  }

  @override
  void update(double dt) {
    // Update game logic here
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // Render game graphics here
    super.render(canvas);
  }

  void generateGameObjects() {
    // Generate game objects here
    // Create an instance of the Components of the game

    List<int> dimensions = backend.getDimensions();

    List<CellWidget> cells = [];

    for (int i = 0; i < dimensions[0]; i++) {
      for (int j = 0; j < dimensions[1]; j++) {
        CellWidget newWidget = CellWidget(50, [i * 50.0, j * 50.0],
            backend.playingGrid.contents["($i, $j)"], backend);
        cells.add(newWidget);
      }
    }

    addAll(cells);
  }
}
