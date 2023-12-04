import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class CellWidget extends SpriteComponent with HasGameRef<Minesweeper> {
  CellWidget(double size, List<double> newPos)
      : super(size: Vector2.all(size), position: Vector2.array(newPos));

  @override
  Future<void> onLoad() async {
    // Load the sprite image
    sprite = await Sprite.load('cell.png');
  }
}
