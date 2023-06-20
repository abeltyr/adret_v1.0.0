// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InputModelAdapter extends TypeAdapter<InputModel> {
  @override
  final int typeId = 8;

  @override
  InputModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InputModel(
      input: fields[0] as dynamic,
      errorStatus: fields[1] as bool,
      errorMessage: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InputModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.input)
      ..writeByte(1)
      ..write(obj.errorStatus)
      ..writeByte(2)
      ..write(obj.errorMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InputModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
