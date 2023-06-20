import 'package:adret/model/sales/index.dart';
import 'package:adret/model/user/index.dart';
import 'package:hive/hive.dart';

part 'index.g.dart';

@HiveType(typeId: 11)
class OrderModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  bool? online;
  @HiveField(2)
  String? note;
  @HiveField(3)
  String? totalPrice;
  @HiveField(4)
  String? totalProfit;
  @HiveField(5)
  String? date;
  @HiveField(6)
  UserModel? seller;
  @HiveField(7)
  List<SalesModel>? sales;
  @HiveField(8)
  String? createdAt;
  @HiveField(9)
  String? updatedAt;
  @HiveField(10)
  String? orderNumber;

  OrderModel({
    this.id,
    this.online,
    this.note,
    this.totalPrice,
    this.totalProfit,
    this.date,
    this.seller,
    this.createdAt,
    this.updatedAt,
    this.sales,
    this.orderNumber,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        online = json['online'],
        note = json['note'],
        totalPrice = "${json['totalPrice']}",
        totalProfit = "${json['totalProfit']}",
        date = json['date'],
        seller = json['seller'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        orderNumber = json['orderNumber'],
        sales = json['sales'];
}
