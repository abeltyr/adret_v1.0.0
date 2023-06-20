import 'package:adret/model/company/index.dart';
import 'package:adret/model/inventory/index.dart';
import 'package:adret/model/user/index.dart';
import 'package:hive/hive.dart';

part 'index.g.dart';

@HiveType(typeId: 2)
class ProductModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? productCode;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? detail;
  @HiveField(4)
  String? category;
  @HiveField(5)
  String? createdAt;
  @HiveField(6)
  String? updatedAt;
  @HiveField(7)
  List<String>? media;
  @HiveField(8)
  CompanyModel? company;
  @HiveField(9)
  UserModel? creator;
  @HiveField(10)
  List<InventoryModel>? inventory;
  @HiveField(11)
  String? inStock;

  ProductModel({
    this.id,
    this.productCode,
    this.title,
    this.detail,
    this.company,
    this.creator,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.media,
    this.inventory,
    this.inStock,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productCode = json['productCode'],
        title = json['title'],
        detail = json['detail'],
        category = json['category'],
        inStock = '${json['inStock']}',
        media = json['media'],
        company = json['company'],
        creator = json['creator'],
        inventory = json['inventory'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
