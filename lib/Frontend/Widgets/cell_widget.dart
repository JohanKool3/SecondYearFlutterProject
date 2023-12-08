import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';
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
      await Sprite.load("revealed_field.png"),
      await Sprite.load("cell_flagged_incorrect.png")
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

    // If the cell is already selected or flagged (with wrong input type), do not allow input
    else if (_inputNotAllowed()) {
      return;
    }

    // If the cell is revealed, and the input type is clear, and the chording is possible, then chord
    else if (_chordingPossible()) {
      backend!.initiateChording(content!);
      return;
    }

    // Toggle flag for the cell
    else if (game.inputType == InputType.flag) {
      sprite = sprites[0];
      backend!.takeUserInput(content!.position, game.inputType);
      return;
    }

    // User has hit a mine, game is over
    else if (content!.isMine) {
      sprite = sprites[4];
      selected = true;
      backend!.takeUserInput(content!.position, game.inputType);
      return;
    } else {
      // Passed through all other possible outcomes, must be a normal cell clear
      _reveal();
      backend!.takeUserInput(content!.position, game.inputType);
      selected = true;

      return;
    }
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
    if (content!.isMine && !content!.isFlagged) {
      sprite = sprites[4];
    }

    if (content!.isFlagged && !content!.isMine) {
      sprite = sprites[14];
    }
  }

  bool _inputNotAllowed() =>
      (selected == true || // Cell is already selected
          content!.isFlagged &&
              game.inputType ==
                  InputType
                      .clear) && // Cell is flagged and the input type is not flag
      !_chordingPossible();

  bool _chordingPossible() =>
      game.inputType == InputType.clear && // Currently Clearing
      content!.isRevealed && // The square is revealed
      backend!.playingGrid.getAdjacentFlagCount(content!.position) ==
          content!.value; // There are sufficient flags around the square
}
