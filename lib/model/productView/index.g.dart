// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductViewModelAdapter extends TypeAdapter<ProductViewModel> {
  @override
  final int typeId = 7;

  @override
  ProductViewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductViewModel(
      id: fields[0] as String?,
      productCode: fields[1] as String?,
      title: fields[3] as InputModel?,
      detail: fields[4] as InputModel?,
      category: fields[5] as InputModel?,
      productVariation: (fields[6] as List?)?.cast<String>(),
      inventory: (fields[7] as List?)?.cast<InventoryInputModel>(),
      media: (fields[2] as List?)?.cast<MediaViewModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductViewModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productCode)
      ..writeByte(2)
      ..write(obj.media)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.detail)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.productVariation)
      ..writeByte(7)
      ..write(obj.inventory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductViewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MediaViewModelAdapter extends TypeAdapter<MediaViewModel> {
  @override
  final int typeId = 15;

  @override
  MediaViewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MediaViewModel(
      file: fields[0] as String?,
      url: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MediaViewModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.file)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaViewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
