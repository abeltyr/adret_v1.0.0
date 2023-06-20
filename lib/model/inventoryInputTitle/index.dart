import 'package:adret/model/input/index.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'index.g.dart';

@HiveType(typeId: 9)
class InventoryInputTitleModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  InputModel value;

  InventoryInputTitleModel({
    required this.title,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': value,
      'title': title,
    };
  }
}
