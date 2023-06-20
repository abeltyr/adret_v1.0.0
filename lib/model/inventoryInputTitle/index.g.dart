// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventoryInputTitleModelAdapter
    extends TypeAdapter<InventoryInputTitleModel> {
  @override
  final int typeId = 9;

  @override
  InventoryInputTitleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventoryInputTitleModel(
      title: fields[0] as String,
      value: fields[1] as InputModel,
    );
  }

  @override
  void write(BinaryWriter writer, InventoryInputTitleModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryInputTitleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
