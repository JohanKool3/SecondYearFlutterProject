// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameStateModelAdapter extends TypeAdapter<GameStateModel> {
  @override
  final int typeId = 1;

  @override
  GameStateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameStateModel(
      fields[0] as int,
      fields[1] as int,
      (fields[2] as List)
          .map((dynamic e) => (e as List).cast<String>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, GameStateModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.difficultyId)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.grid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameStateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
