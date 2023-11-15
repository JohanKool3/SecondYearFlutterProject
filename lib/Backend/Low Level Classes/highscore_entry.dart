import 'package:flutter_application_1/Backend/Enums/difficulty.dart';

class HighscoreEntry{

  late String player;
  late Difficulty difficulty;
  late int time;

  HighscoreEntry(this.player, this.difficulty, this.time);
}