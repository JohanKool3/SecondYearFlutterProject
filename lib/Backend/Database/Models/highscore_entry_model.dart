import 'package:hive/hive.dart';

part 'highscore_entry_model.g.dart';

@HiveType(typeId: 0)
class HighscoreEntry {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String player;

  @HiveField(2)
  late int difficultyId;

  @HiveField(3)
  late int time;

  HighscoreEntry(this.id, this.player, this.difficultyId, this.time);
}
