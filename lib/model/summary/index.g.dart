// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SummaryModelAdapter extends TypeAdapter<SummaryModel> {
  @override
  final int typeId = 4;

  @override
  SummaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SummaryModel(
      id: fields[0] as String?,
      earning: fields[1] as String?,
      profit: fields[2] as String?,
      managerAccepted: fields[3] as bool?,
      date: fields[4] as String?,
      startDate: fields[5] as String?,
      endDate: fields[6] as String?,
      manager: fields[7] as UserModel?,
      employee: fields[8] as UserModel?,
      createdAt: fields[9] as String?,
      updatedAt: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SummaryModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.earning)
      ..writeByte(2)
      ..write(obj.profit)
      ..writeByte(3)
      ..write(obj.managerAccepted)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.startDate)
      ..writeByte(6)
      ..write(obj.endDate)
      ..writeByte(7)
      ..write(obj.manager)
      ..writeByte(8)
      ..write(obj.employee)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SummaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
