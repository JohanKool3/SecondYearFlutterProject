import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  runApp(
    GameWidget(game: MyGame()),
  );
}

class MyGame extends Game {
  @override
  void update(double dt) {}

  @override
  void render(Canvas canvas) {}}