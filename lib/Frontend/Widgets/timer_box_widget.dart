import 'package:flame/components.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';

class TimerBoxWidget extends TextBoxComponent {
  TimerBoxWidget(Vector2 newPos, Vector2 size, this.backend)
      : super(
          text: "00:00",
          position: newPos,
          size: size,
          anchor: Anchor.topLeft,
        );

  MinesweeperBackend backend;

  @override
  void update(double dt) {
    super.update(dt);
    _updateText();
  }

  void _updateText() {
    text = backend.information.time.toString();

    int minutes = backend.information.time ~/ 60;
    int seconds = backend.information.time % 60;

    // Add a 0 if the amount of minutes or seconds is less than 10
    String minutesString = minutes < 10 ? "0$minutes" : minutes.toString();
    String secondsString = seconds < 10 ? "0$seconds" : seconds.toString();

    // Set the text to the correct format
    text = "$minutesString:$secondsString";
  }
}
