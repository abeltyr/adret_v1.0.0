import 'package:adret/model/input/index.dart';
import 'package:adret/model/inventoryInputTitle/index.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'index.g.dart';

@HiveType(typeId: 10)
class InventoryInputModel {
  List<InventoryInputTitleModel>? title;
  @HiveField(0)
  InputModel amount;
  @HiveField(1)
  int? sales;
  @HiveField(2)
  InputModel initialPrice;
  @HiveField(3)
  InputModel minSellingPriceEstimation;
  @HiveField(4)
  InputModel maxSellingPriceEstimation;
  @HiveField(5)
  int? media;
  @HiveField(6)
  String? id;

  InventoryInputModel({
    this.title,
    required this.amount,
    required this.sales,
    required this.initialPrice,
    required this.minSellingPriceEstimation,
    required this.maxSellingPriceEstimation,
    this.media,
    this.id,
  });
}
