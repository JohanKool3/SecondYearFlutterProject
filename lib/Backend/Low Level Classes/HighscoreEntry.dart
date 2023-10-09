import '../Enums/Difficulty.dart';


class HighscoreEntry{

  String _player = "";
  Difficulty _gameDifficulty = Difficulty.easy;
  double _time = 0;

  HighscoreEntry(this._player, this._gameDifficulty, this._time);

  // Getters
  String get Player => _player;
  double get Time => _time;
  Difficulty get GameDifficulty => _gameDifficulty;

}