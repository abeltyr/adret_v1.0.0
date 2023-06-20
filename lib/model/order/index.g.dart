// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 11;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      id: fields[0] as String?,
      online: fields[1] as bool?,
      note: fields[2] as String?,
      totalPrice: fields[3] as String?,
      totalProfit: fields[4] as String?,
      date: fields[5] as String?,
      seller: fields[6] as UserModel?,
      createdAt: fields[8] as String?,
      updatedAt: fields[9] as String?,
      sales: (fields[7] as List?)?.cast<SalesModel>(),
      orderNumber: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.online)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.totalPrice)
      ..writeByte(4)
      ..write(obj.totalProfit)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.seller)
      ..writeByte(7)
      ..write(obj.sales)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.orderNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
