import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';

class Button extends SpriteComponent with HoverCallbacks, TapCallbacks {
  Button(Vector2 size, List<double> newPos, this.backend)
      : super(size: size, position: Vector2.array(newPos));

  MinesweeperBackend? backend;
}
