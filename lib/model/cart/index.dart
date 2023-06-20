import 'package:adret/model/input/index.dart';
import 'package:adret/model/inventory/index.dart';
import 'package:hive/hive.dart';

part 'index.g.dart';

@HiveType(typeId: 12)
class CartModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String productCode;
  @HiveField(2)
  InventoryModel inventory;
  @HiveField(3)
  InputModel amount;
  @HiveField(4)
  InputModel sellingPrice;
  @HiveField(5)
  double totalPrice;
  @HiveField(6)
  String? media;
  @HiveField(7)
  int? productIndex;
  @HiveField(8)
  int? inventoryIndex;

  CartModel({
    required this.title,
    required this.productCode,
    required this.inventory,
    required this.amount,
    required this.sellingPrice,
    required this.totalPrice,
    this.media,
    this.productIndex,
    this.inventoryIndex,
  });

  CartModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        productCode = json['productCode'],
        inventory = json['inventory'],
        amount = json['amount'],
        sellingPrice = json['sellingPrice'],
        totalPrice = json['totalPrice'],
        media = json['media'],
        productIndex = json['productIndex'],
        inventoryIndex = json['inventoryIndex'];
}
