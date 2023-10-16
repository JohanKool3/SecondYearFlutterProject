import 'package:flutter/material.dart';
import 'minesweeper.dart';
import 'package:flame/game.dart';

void main() {
  final game = MyGame();
  runApp(MaterialApp(home: Scaffold(body: GameWidget(game: game))));
}
