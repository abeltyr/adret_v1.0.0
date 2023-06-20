import 'package:adret/model/company/index.dart';
import 'package:hive/hive.dart';

part 'index.g.dart';

@HiveType(typeId: 5)
class UserModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? fullName;
  @HiveField(2)
  String? phoneNumber;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? userName;
  @HiveField(5)
  bool? isActive;
  @HiveField(6)
  String? userRole;
  @HiveField(7)
  CompanyModel? company;
  @HiveField(8)
  String? createdAt;
  @HiveField(9)
  String? updatedAt;

  UserModel({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.userName,
    this.isActive,
    this.userRole,
    this.company,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fullName = json['fullName'],
        phoneNumber = json['phoneNumber'],
        email = json['email'],
        userName = json['userName'],
        isActive = json['isActive'],
        userRole = json['userRole'],
        company = json['company'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
