import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Backend/Database/Models/HighScore/GameState/game_state_model.dart';
import 'package:flutter_application_1/Backend/Enums/difficulty.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';
import 'package:hive_flutter/adapters.dart';

late MinesweeperBackend backend;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  await Hive.initFlutter();
  Hive.registerAdapter(GameStateModelAdapter());

  backend = MinesweeperBackend(
      await Hive.openBox<GameStateModel>('gameStateProduction'));

  Minesweeper game = Minesweeper(backend);

  // When in debugging mode, removes the need to keep reloading
  runApp(
    GameWidget(game: kDebugMode ? Minesweeper(backend) : game),
  );

  runApp(GameWidget(game: Minesweeper(backend)));
}
