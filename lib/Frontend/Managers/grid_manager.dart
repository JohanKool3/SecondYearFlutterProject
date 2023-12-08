import 'package:flame/components.dart';
import 'package:flutter_application_1/Frontend/Widgets/cell_widget.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';

class GridManager extends PositionComponent {
  List<CellWidget> cells = [];
  MinesweeperBackend backend;

  GridManager(this.backend) {
    generate();
  }

  void generate() {
    List<int> dimensions = backend.getDimensions();
    for (int i = 0; i < dimensions[0]; i++) {
      for (int j = 0; j < dimensions[1]; j++) {
        CellWidget newWidget = CellWidget(50, [i * 50.0, j * 50.0],
            backend.playingGrid.contents["($i, $j)"], backend);
        cells.add(newWidget);
      }
    }
  }
}
