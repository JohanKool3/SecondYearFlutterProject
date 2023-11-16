import 'package:flutter/material.dart';
import 'package:flutter_application_1/Backend/Database/Models/HighScore/GameState/game_state_model.dart';
import 'package:flutter_application_1/Backend/minesweeper_backend.dart';
import 'package:hive_flutter/adapters.dart';

late MinesweeperBackend backend;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(GameStateModelAdapter());

  backend = MinesweeperBackend(
      await Hive.openBox<GameStateModel>('gameStateProduction'));
  backend.saveGameState();
  Hive.close();

  // runApp(
  //   const MaterialApp(
  //     home: MyFlutterApp(),
  //   ),
  // );
}

class MyFlutterApp extends StatefulWidget {
  const MyFlutterApp({Key? key}) : super(key: key);

  @override
  _MyFlutterAppState createState() => _MyFlutterAppState();
}

class _MyFlutterAppState extends State<MyFlutterApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Minesweeper'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Minesweeper!',
            ),
          ],
        ),
      ),
    );
  }
}
