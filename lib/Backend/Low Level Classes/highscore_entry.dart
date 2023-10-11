import '../Enums/Difficulty.dart';

class HighscoreEntry {
  final String _player;
  final Difficulty _gameDifficulty;
  final double _time;

  HighscoreEntry(this._player, this._gameDifficulty, this._time);

  // Getters
  String get player => _player;
  double get time => _time;
  Difficulty get gameDifficulty => _gameDifficulty;
}
