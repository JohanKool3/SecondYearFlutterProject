import 'package:flame/game.dart';
import 'Frontend/cell_widget.dart';

class MyGame extends FlameGame {
  var gridSize = 10;
  @override
  Future<void> onLoad() async {
    var newCellWidget = CellWidget(gridSize);
    newCellWidget.setPosition(100, 100);
    await add(newCellWidget);
  }
}
