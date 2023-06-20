import 'package:adret/model/inventory/index.dart';
import 'package:hive/hive.dart';

part 'index.g.dart';

@HiveType(typeId: 3)
class SalesModel {
  @HiveField(0)
  String? profit;
  @HiveField(1)
  String? sellingPrice;
  @HiveField(2)
  InventoryModel? inventory;

  SalesModel({
    this.profit,
    this.sellingPrice,
    this.inventory,
  });

  SalesModel.fromJson(Map<String, dynamic> json)
      : sellingPrice = "${json['sellingPrice']}",
        profit = "${json['profit']}",
        inventory = json['inventory'];
}
