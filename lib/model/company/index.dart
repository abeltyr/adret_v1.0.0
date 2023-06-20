import 'package:adret/model/user/index.dart';
import 'package:hive/hive.dart';

part 'index.g.dart';

@HiveType(typeId: 0)
class CompanyModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? companyCode;
  @HiveField(3)
  String? detail;
  @HiveField(4)
  String? longitude;
  @HiveField(5)
  String? latitude;
  @HiveField(6)
  UserModel? owner;
  @HiveField(7)
  String? createdAt;
  @HiveField(8)
  String? updatedAt;

  CompanyModel({
    this.id,
    this.name,
    this.companyCode,
    this.detail,
    this.longitude,
    this.latitude,
    this.owner,
    this.createdAt,
    this.updatedAt,
  });

  CompanyModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        companyCode = json['companyCode'],
        detail = json['detail'],
        longitude = json['longitude'],
        latitude = json['latitude'],
        owner = json['owner'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
