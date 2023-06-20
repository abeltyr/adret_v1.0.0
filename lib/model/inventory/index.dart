import 'package:adret/model/inventory/inventoryVariation/index.dart';
import 'package:adret/model/product/index.dart';
import 'package:hive/hive.dart';

part 'index.g.dart';

@HiveType(typeId: 1)
class InventoryModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? salesAmount;
  @HiveField(3)
  String? available;
  @HiveField(4)
  String? initialPrice;
  @HiveField(5)
  String? minSellingPriceEstimation;
  @HiveField(6)
  String? maxSellingPriceEstimation;
  @HiveField(7)
  String? createdAt;
  @HiveField(8)
  String? updatedAt;
  @HiveField(9)
  List<InventoryVariation>? inventoryVariation;
  @HiveField(10)
  String? media;
  @HiveField(11)
  ProductModel? product;

  InventoryModel({
    this.id,
    this.title,
    this.salesAmount,
    this.available,
    this.initialPrice,
    this.minSellingPriceEstimation,
    this.maxSellingPriceEstimation,
    this.media,
    this.inventoryVariation,
    this.product,
    this.createdAt,
    this.updatedAt,
  });

  InventoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        salesAmount = '${json['salesAmount']}',
        available = '${json['available']}',
        initialPrice = "${json['initialPrice']}",
        minSellingPriceEstimation = "${json['minSellingPriceEstimation']}",
        maxSellingPriceEstimation = "${json['maxSellingPriceEstimation']}",
        media = json['media'],
        inventoryVariation = json['inventoryVariation'],
        product = json['product'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
