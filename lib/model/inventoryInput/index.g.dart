// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventoryInputModelAdapter extends TypeAdapter<InventoryInputModel> {
  @override
  final int typeId = 10;

  @override
  InventoryInputModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventoryInputModel(
      amount: fields[0] as InputModel,
      sales: fields[1] as int?,
      initialPrice: fields[2] as InputModel,
      minSellingPriceEstimation: fields[3] as InputModel,
      maxSellingPriceEstimation: fields[4] as InputModel,
      media: fields[5] as int?,
      id: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InventoryInputModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.sales)
      ..writeByte(2)
      ..write(obj.initialPrice)
      ..writeByte(3)
      ..write(obj.minSellingPriceEstimation)
      ..writeByte(4)
      ..write(obj.maxSellingPriceEstimation)
      ..writeByte(5)
      ..write(obj.media)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryInputModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
