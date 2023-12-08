import 'package:flame/components.dart';
import 'package:flutter_application_1/Frontend/Widgets/cell_widget.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';

class GridManager extends PositionComponent {
  List<CellWidget> cells = [];
  MinesweeperBackend backend;
  Vector2 positionOffset = Vector2.zero();
  double cellDimensions;

  GridManager(this.backend, this.positionOffset, {this.cellDimensions = 50}) {
    /// Position is the top left corner of the grid
    /// Size is the size of the grid
    generate();
  }

  void generate() {
    List<int> dimensions = backend.getDimensions();

    double xOffset = positionOffset.x;
    double yOffset = positionOffset.y;

    for (int i = 0; i < dimensions[0]; i++) {
      for (int j = 0; j < dimensions[1]; j++) {
        CellWidget newWidget = CellWidget(
            cellDimensions,
            [i * cellDimensions + xOffset, j * cellDimensions + yOffset],
            backend.playingGrid.contents["($i, $j)"],
            backend);
        cells.add(newWidget);
      }
    }
  }
}
