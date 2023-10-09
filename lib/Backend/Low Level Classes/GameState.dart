import '../Managers/Grid.dart';

class GameState{

  double _time = 0;
  late Grid _gameGrid;


  GameState(this._time, this._gameGrid);

  // Getters
  double get Time => _time;
  Grid get GameGrid => _gameGrid;
}