import 'package:hive_flutter/hive_flutter.dart';

part 'index.g.dart';

@HiveType(typeId: 8)
class InputModel {
  @HiveField(0)
  dynamic input;
  @HiveField(1)
  bool errorStatus;
  @HiveField(2)
  String? errorMessage;

  InputModel({
    this.input,
    this.errorStatus = false,
    this.errorMessage = "",
  });
}
