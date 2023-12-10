import 'package:flame/components.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
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

  static void revealMinesOnGameOver(CellWidget cell) {
    List<Sprite> sprites = cell.sprites;
    bool isMine = cell.content!.isMine;
    bool isFlagged = cell.content!.isFlagged;

    MinesweeperBackend? backend = cell.backend!;

    if (isMine && !isFlagged) {
      cell.sprite = sprites[4];
    }

    if (isFlagged && !isMine) {
      cell.sprite = sprites[14];
    }

    // Stop the timer on game over
    backend.stopTimer();
    backend.removeSaveState(); // Hit a mine, remove the save state
  }
}
