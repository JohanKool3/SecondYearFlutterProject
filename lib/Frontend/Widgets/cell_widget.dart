import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:flutter_application_1/Frontend/Managers/cell_input_manager.dart';
import 'package:flutter_application_1/Frontend/Managers/cell_permissions_manager.dart';
import 'package:flutter_application_1/Frontend/Managers/cell_visibility_manager.dart';
import 'package:flutter_application_1/Frontend/Templates/button.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class CellWidget extends Button with HasGameRef<Minesweeper> {
  CellWidget(double size, Vector2 newPos, this.content, backend)
      : super("cell", Vector2.all(size), newPos, backend);

  GridContent? content;
  // When the cell has been selected, it cannot be selected again
  bool selected = false;
  //  Purely for making interaction easier (when the player moves their mouse on the cell, still counts as an input)
  bool cellPressed = false;
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
      CellVisibilityManager.reveal(this);
      selected = true;
    }
  }

  @override
  void update(double dt) {
    if (content!.isFlagged) {
      // Update if the cell is flagged via non input means (e.g. loading a save state)
      sprite = sprites[3];
    } else if (content!.isRevealed) {
      CellVisibilityManager.reveal(this);
      selected = true;
    }

    // Update the sprite if the cell is pressed
    if (cellPressed) {
      CellInputManager.takeInput(this);
    }

    // Update the sprite if the game is over
    if (backend!.playingGrid.isGameOver) {
      CellVisibilityManager.revealMinesOnGameOver(this);
    }
    super.update(dt);
  }

  @override
  void onHoverEnter() async {
    // Change the sprite when the mouse enters the cell
    if (CellPermissionsManager.inputNotAllowed(this)) return;
    super.onHoverEnter();
  }

  @override
  void onHoverExit() {
    if (CellPermissionsManager.inputNotAllowed(this)) return;
    super.onHoverExit();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (CellPermissionsManager.inputNotAllowed(this)) return;
    cellPressed = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    CellInputManager.takeInput(this);
  }
}
