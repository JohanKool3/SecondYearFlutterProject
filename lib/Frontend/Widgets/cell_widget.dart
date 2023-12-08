import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:flutter_application_1/Frontend/Templates/button.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class CellWidget extends Button with HasGameRef<Minesweeper> {
  CellWidget(double size, Vector2 newPos, this.content, backend)
      : super("cell", Vector2.all(size), newPos, backend);

  GridContent? content;
  bool selected = false;

  @override
  Future<void> onLoad() async {
    // Add the sprite to the list of sprites
    sprites = [
      await Sprite.load("cell.png"),
      await Sprite.load("cell_hover.png"),
      await Sprite.load("cell_revealed.png"),
      await Sprite.load("cell_flagged.png"),
      await Sprite.load("cell_mine.png"),
      await Sprite.load("revealed_1.png"),
      await Sprite.load("revealed_2.png"),
      await Sprite.load("revealed_3.png"),
      await Sprite.load("revealed_4.png"),
      await Sprite.load("revealed_5.png"),
      await Sprite.load("revealed_6.png"),
      await Sprite.load("revealed_7.png"),
      await Sprite.load("revealed_8.png"),
      await Sprite.load("revealed_field.png")
    ];

    // Set the sprite to the first sprite in the list
    sprite = sprites[0];

    if (content!.isFlagged) {
      sprite = sprites[3];
    } else if (content!.isRevealed) {
      _reveal();
      selected = true;
    }
  }

  @override
  void update(double dt) {
    // Update the sprite if the cell has been flagged, or revealed
    if (content!.isFlagged) {
      sprite = sprites[3];
    } else if (content!.isRevealed) {
      _reveal();
      selected = true;
    }

    // Update the sprite if the game is over
    if (backend!.playingGrid.isGameOver) {
      _revealMinesOnGameOver();
    }
    super.update(dt);
  }

  @override
  onHoverEnter() async {
    // Change the sprite when the mouse enters the cell
    if (_inputNotAllowed()) return;
    super.onHoverEnter();
  }

  @override
  void onHoverExit() {
    if (_inputNotAllowed()) return;
    super.onHoverExit();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (_inputNotAllowed()) return;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    // Removes the save state if the game is over or won
    if (backend!.playingGrid.isGameOver || backend!.playingGrid.gameIsWon()) {
      backend!.removeSaveState();
      return;
    }

    backend!.takeUserInput(content!.position, game.inputType);
    // Reveal the cell
    super.onTapUp(event);

    // Cannot reveal a flag
    if (content!.isFlagged) {
      return;
    }

    if (content!.isMine) {
      sprite = sprites[4];
      selected = true;
      return;
    }

    _reveal();
    selected = true;

    return;
  }

  void assignContent(GridContent contentIn) {
    content = contentIn;
  }

  void _reveal() {
    sprite = switch (content!.value) {
      1 => sprites[5],
      2 => sprites[6],
      3 => sprites[7],
      4 => sprites[8],
      5 => sprites[9],
      6 => sprites[10],
      7 => sprites[11],
      8 => sprites[12],
      _ => sprites[13], // Must be an empty cell
    };
  }

  void _revealMinesOnGameOver() {
    if (content!.isMine) {
      sprite = sprites[4];
    }
  }

  bool _inputNotAllowed() => selected == true || content!.isFlagged;
}
