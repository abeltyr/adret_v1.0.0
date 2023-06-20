import 'package:hive/hive.dart';

part 'index.g.dart';

@HiveType(typeId: 13)
class UserSettingModel {
  @HiveField(0)
  String? accessToken;
  @HiveField(1)
  String? refreshToken;
  @HiveField(2)
  String? idToken;
  @HiveField(3)
  String? companyId;
  @HiveField(4)
  String? userName;
  @HiveField(5)
  int? fetchTime;

  UserSettingModel({
    this.accessToken,
    this.refreshToken,
    this.idToken,
    this.companyId,
    this.userName,
    this.fetchTime,
  });
}
