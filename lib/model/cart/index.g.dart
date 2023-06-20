// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartModelAdapter extends TypeAdapter<CartModel> {
  @override
  final int typeId = 12;

  @override
  CartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartModel(
      title: fields[0] as String,
      productCode: fields[1] as String,
      inventory: fields[2] as InventoryModel,
      amount: fields[3] as InputModel,
      sellingPrice: fields[4] as InputModel,
      totalPrice: fields[5] as double,
      media: fields[6] as String?,
      productIndex: fields[7] as int?,
      inventoryIndex: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CartModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.productCode)
      ..writeByte(2)
      ..write(obj.inventory)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.sellingPrice)
      ..writeByte(5)
      ..write(obj.totalPrice)
      ..writeByte(6)
      ..write(obj.media)
      ..writeByte(7)
      ..write(obj.productIndex)
      ..writeByte(8)
      ..write(obj.inventoryIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
