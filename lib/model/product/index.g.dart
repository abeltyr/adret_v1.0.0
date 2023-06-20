// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 2;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String?,
      productCode: fields[1] as String?,
      title: fields[2] as String?,
      detail: fields[3] as String?,
      company: fields[8] as CompanyModel?,
      creator: fields[9] as UserModel?,
      category: fields[4] as String?,
      createdAt: fields[5] as String?,
      updatedAt: fields[6] as String?,
      media: (fields[7] as List?)?.cast<String>(),
      inventory: (fields[10] as List?)?.cast<InventoryModel>(),
      inStock: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productCode)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.detail)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.media)
      ..writeByte(8)
      ..write(obj.company)
      ..writeByte(9)
      ..write(obj.creator)
      ..writeByte(10)
      ..write(obj.inventory)
      ..writeByte(11)
      ..write(obj.inStock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
