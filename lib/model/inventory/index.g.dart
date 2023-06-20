// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventoryModelAdapter extends TypeAdapter<InventoryModel> {
  @override
  final int typeId = 1;

  @override
  InventoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventoryModel(
      id: fields[0] as String?,
      title: fields[1] as String?,
      salesAmount: fields[2] as String?,
      available: fields[3] as String?,
      initialPrice: fields[4] as String?,
      minSellingPriceEstimation: fields[5] as String?,
      maxSellingPriceEstimation: fields[6] as String?,
      media: fields[10] as String?,
      inventoryVariation: (fields[9] as List?)?.cast<InventoryVariation>(),
      product: fields[11] as ProductModel?,
      createdAt: fields[7] as String?,
      updatedAt: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InventoryModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.salesAmount)
      ..writeByte(3)
      ..write(obj.available)
      ..writeByte(4)
      ..write(obj.initialPrice)
      ..writeByte(5)
      ..write(obj.minSellingPriceEstimation)
      ..writeByte(6)
      ..write(obj.maxSellingPriceEstimation)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.inventoryVariation)
      ..writeByte(10)
      ..write(obj.media)
      ..writeByte(11)
      ..write(obj.product);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
