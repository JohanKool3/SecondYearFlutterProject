import 'package:hive/hive.dart';

part 'game_state_model.g.dart';

@HiveType(typeId: 1)
class GameStateModel {
  @HiveField(0)
  late int difficultyId;

  @HiveField(1)
  late int time;

  @HiveField(2)
  late List<List<String>> grid;

  GameStateModel(this.difficultyId, this.time, this.grid);
}
