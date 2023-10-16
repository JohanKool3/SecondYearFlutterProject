import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class CellWidget extends PositionComponent with TapCallbacks {
  CellWidget(this.squareAmount) : super(anchor: Anchor.center);

  late var squareAmount = 10;
  late var defaultSquareSize = 100;

  final _colour = Paint()..color = Color.fromARGB(68, 189, 200, 231);

  void setPosition(int x, int y) {
    position = Vector2(x.toDouble(), y.toDouble());
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    // Work out the changing multiplier for the change in screen size
    int multiplier = 1;

    var newSquareSize = defaultSquareSize * multiplier;
    this.size = Vector2(newSquareSize.toDouble(), newSquareSize.toDouble());
  }

  /// We will store all current circles into this map, keyed by the `pointerId`
  /// of the event that created the circle.

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _colour);
  }

  // TODO: Look into fixing weighting. Look for a long press first, prevents scenarios where a player flags but clicks a mine by accident
  // Maybe use something like a stack to detect long presses first...
  @override
  void onTapDown(TapDownEvent event) {
    print("Short Press");
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    print("Long Press");
  }
}
