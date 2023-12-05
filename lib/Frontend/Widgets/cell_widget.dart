import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class CellWidget extends SpriteComponent with HoverCallbacks, TapCallbacks {
  CellWidget(double size, List<double> newPos)
      : super(size: Vector2.all(size), position: Vector2.array(newPos));

  List<Sprite?> sprites = [];
  @override
  Future<void> onLoad() async {
    // Add the sprite to the list of sprites
    sprites = [
      await Sprite.load("cell.png"),
      await Sprite.load("cell_hover.png"),
      await Sprite.load("cell_revealed.png"),
    ];

    // Set the sprite to the first sprite in the list
    sprite = sprites[0];
  }

  @override
  onHoverEnter() async {
    // Change the sprite when the mouse enters the cell
    sprite = sprites[1];
  }

  @override
  void onHoverExit() {
    // TODO: implement onHoverExit
    sprite = sprites[0];
    super.onHoverExit();
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    sprite = sprites[2];
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    sprite = sprites[1];
    super.onTapUp(event);
  }
}
