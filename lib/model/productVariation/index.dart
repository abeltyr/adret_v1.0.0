import 'package:hive/hive.dart';

part 'index.g.dart';

@HiveType(typeId: 6)
class ProductVariationListModel {
  @HiveField(0)
  List<ProductVariationModel> variations;

  ProductVariationListModel({
    this.variations = const [],
  });
}

@HiveType(typeId: 14)
class ProductVariationModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  bool selected;

  ProductVariationModel({
    required this.title,
    this.selected = true,
  });
}
