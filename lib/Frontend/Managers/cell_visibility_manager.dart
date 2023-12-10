import 'package:flame/components.dart';
import 'package:flutter_application_1/Frontend/Widgets/cell_widget.dart';

class CellVisibilityManager {
  static void reveal(CellWidget cell) {
    List<Sprite> sprites = cell.sprites;
    cell.sprite = switch (cell.content!.value) {
      2 => sprites[6],
      1 => sprites[5],
      3 => sprites[7],
      4 => sprites[8],
      5 => sprites[9],
      6 => sprites[10],
      7 => sprites[11],
      8 => sprites[12],
      _ => sprites[13], // Must be an empty cell
    };
  }
}
