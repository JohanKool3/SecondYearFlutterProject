import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/grid_content.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class CellWidget extends SpriteComponent with HoverCallbacks, TapCallbacks {
  CellWidget(double size, List<double> newPos, this.content)
      : super(size: Vector2.all(size), position: Vector2.array(newPos));

  GridContent? content;
  bool selected = false;
  List<Sprite?> sprites = [];
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
    }
  }

  @override
  onHoverEnter() async {
    // Change the sprite when the mouse enters the cell
    if (selected == true) return;
    sprite = sprites[1];
  }

  @override
  void onHoverExit() {
    // TODO: implement onHoverExit
    if (selected == true) return;
    sprite = sprites[0];
    super.onHoverExit();
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    if (selected == true) return;
    sprite = sprites[2];
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (selected == true) return;
    sprite = sprites[1];
    // Revleal the cell
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
      _ => sprites[13], // Must be a
    };
  }
}
