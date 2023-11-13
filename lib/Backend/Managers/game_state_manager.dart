import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/Low%20Level%20Classes/game_state.dart';

class GameStateManager {
  late GameState currentState;
  Difficulty difficulty = Difficulty.easy;

  GameStateManager(this.difficulty) {
    //Try to load first! If you cant load then generate a new one
    if (!loadGameState()) {
      newGameState();
    }
  }

  void newGameState() {
    currentState = GameState(difficulty, 0);
  }
  
  void newGameStateWithDifficulty(Difficulty newDifficulty) {
    setNewDifficulty(newDifficulty);
    currentState = GameState(newDifficulty, 0);
    
  }

  void setNewDifficulty(Difficulty newDifficulty) => difficulty = newDifficulty;

  bool loadGameState() {
    // TODO: Load From Database using a given query string. This will be hard coded

    return false;
  }
}
