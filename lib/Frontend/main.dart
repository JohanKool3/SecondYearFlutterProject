import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Backend/Database/Models/HighScore/GameState/game_state_model.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:flutter_application_1/Frontend/minesweeper.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_application_1/Backend/Enums/input_type.dart';

late MinesweeperBackend backend;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(GameStateModelAdapter());

  backend = MinesweeperBackend(
      await Hive.openBox<GameStateModel>('gameStateProduction'));

  // runApp(
  //   const MaterialApp(
  //     home: MyFlutterApp(),
  //   ),
  // );
  runApp(GameWidget(game: Minesweeper(backend)));
  backend.saveGameState();
  Hive.close();
}
