// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventHiveModelAdapter extends TypeAdapter<EventHiveModel> {
  @override
  final int typeId = 1;

  @override
  EventHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventHiveModel(
      id: fields[0] as String,
      title: fields[1] as String,
      location: fields[2] as String,
      details: fields[3] as String,
      participants: fields[4] as int,
      availableSpots: fields[5] as int,
      date: fields[6] as String,
      path: fields[7] as String,
      type: fields[8] as String,
      isJoined: fields[9] as bool,
      ratings: (fields[10] as List).cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, EventHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.details)
      ..writeByte(4)
      ..write(obj.participants)
      ..writeByte(5)
      ..write(obj.availableSpots)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.path)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.isJoined)
      ..writeByte(10)
      ..write(obj.ratings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
