import '../Managers/Grid.dart';

class GameState {
  late double _time = 0;
  late final Grid _gameGrid;

  GameState(this._time, this._gameGrid);

  // Getters
  double get Time => _time;
  Grid get GameGrid => _gameGrid;
}
