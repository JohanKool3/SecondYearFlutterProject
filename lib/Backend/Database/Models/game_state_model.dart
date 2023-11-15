import 'package:hive/hive.dart';

part 'game_state_model.g.dart';

@HiveType(typeId: 1)
class GameStateModel {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late int difficultyId;

  @HiveField(2)
  late int time;

  @HiveField(3)
  late List<List<String>> grid;

  GameStateModel(this.id, this.difficultyId, this.time, this.grid);
}
