import 'package:adret/model/user/index.dart';
import 'package:hive/hive.dart';

part 'index.g.dart';

@HiveType(typeId: 4)
class SummaryModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? earning;
  @HiveField(2)
  String? profit;
  @HiveField(3)
  bool? managerAccepted;
  @HiveField(4)
  String? date;
  @HiveField(5)
  String? startDate;
  @HiveField(6)
  String? endDate;
  @HiveField(7)
  UserModel? manager;
  @HiveField(8)
  UserModel? employee;
  @HiveField(9)
  String? createdAt;
  @HiveField(10)
  String? updatedAt;

  SummaryModel({
    this.id,
    this.earning,
    this.profit,
    this.managerAccepted,
    this.date,
    this.startDate,
    this.endDate,
    this.manager,
    this.employee,
    this.createdAt,
    this.updatedAt,
  });

  SummaryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        earning = "${json['earning']}",
        profit = "${json['profit']}",
        managerAccepted = json['managerAccepted'],
        date = json['date'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        manager = json['manager'],
        employee = json['employee'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
