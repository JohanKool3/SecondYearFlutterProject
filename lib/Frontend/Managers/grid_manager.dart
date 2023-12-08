import 'package:flame/components.dart';
import 'package:flutter_application_1/Frontend/Widgets/cell_widget.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';

class GridManager extends PositionComponent {
  List<CellWidget> cells = [];
  MinesweeperBackend backend;
  Vector2 positionOffset = Vector2.zero();
  double cellDimensions;

  Vector2 bottomLeft = Vector2.zero();

  GridManager(this.backend, this.positionOffset, {this.cellDimensions = 50}) {
    /// Position is the top left corner of the grid
    /// Size is the size of the grid

    // Calculate the cell dimensions as if the grid was setup for easy.

    cellDimensions = (9 / backend.getDimensions()[0]) * cellDimensions;
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
    // For dynamically changing the layout of the GUI
    bottomLeft = Vector2(xOffset, dimensions[1] * cellDimensions + yOffset);
  }
}
