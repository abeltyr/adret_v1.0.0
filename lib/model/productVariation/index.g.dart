// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductVariationListModelAdapter
    extends TypeAdapter<ProductVariationListModel> {
  @override
  final int typeId = 6;

  @override
  ProductVariationListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductVariationListModel(
      variations: (fields[0] as List).cast<ProductVariationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductVariationListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.variations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductVariationListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductVariationModelAdapter extends TypeAdapter<ProductVariationModel> {
  @override
  final int typeId = 14;

  @override
  ProductVariationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductVariationModel(
      title: fields[0] as String,
      selected: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ProductVariationModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.selected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductVariationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
