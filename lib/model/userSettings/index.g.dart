// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSettingModelAdapter extends TypeAdapter<UserSettingModel> {
  @override
  final int typeId = 13;

  @override
  UserSettingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSettingModel(
      accessToken: fields[0] as String?,
      refreshToken: fields[1] as String?,
      idToken: fields[2] as String?,
      companyId: fields[3] as String?,
      userName: fields[4] as String?,
      fetchTime: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserSettingModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.refreshToken)
      ..writeByte(2)
      ..write(obj.idToken)
      ..writeByte(3)
      ..write(obj.companyId)
      ..writeByte(4)
      ..write(obj.userName)
      ..writeByte(5)
      ..write(obj.fetchTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
