import 'package:adret/model/input/index.dart';
import 'package:adret/model/inventoryInput/index.dart';
import 'package:hive/hive.dart';

part 'index.g.dart';

@HiveType(typeId: 7)
class ProductViewModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? productCode;
  @HiveField(2)
  List<MediaViewModel>? media;
  @HiveField(3)
  InputModel? title;
  @HiveField(4)
  InputModel? detail;
  @HiveField(5)
  InputModel? category;
  @HiveField(6)
  List<String>? productVariation;
  @HiveField(7)
  List<InventoryInputModel>? inventory;

  ProductViewModel({
    this.id,
    this.productCode,
    this.title,
    this.detail,
    this.category,
    this.productVariation,
    this.inventory,
    this.media,
  });
}

@HiveType(typeId: 15)
class MediaViewModel {
  @HiveField(0)
  String? file;
  @HiveField(1)
  String? url;

  MediaViewModel({
    this.file,
    this.url,
  });
}
