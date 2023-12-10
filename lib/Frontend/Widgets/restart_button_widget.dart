import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/Frontend/Templates/button.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';

class RestartButtonWidget extends Button with HasGameRef<Minesweeper> {
  RestartButtonWidget(Vector2 size, Vector2 newPos, backend)
      : super("restart", size, newPos, backend);

  @override
  void onTapUp(TapUpEvent event) {
    game.generateNewGame(backend!.information.difficulty);
    super.onTapUp(event);
  }
}
