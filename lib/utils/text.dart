import 'package:adret/model/user/index.dart';
import 'package:hive_flutter/adapters.dart';

String capitalize(String? data) {
  if (data != null && data.isNotEmpty) {
    return "${data[0].toUpperCase()}${data.substring(1).toLowerCase()}";
  }
  return "";
}

String companyNameRemover(String? data) {
  var hiveUser = Hive.box<UserModel>('user');
  var user = hiveUser.get("current");
  if (data != null &&
      data.isNotEmpty &&
      data.contains('${user!.company!.companyCode!}-')) {
    return data.split('${user.company!.companyCode!}-')[1];
  }
  return "";
}

String avatarCut(String? data) {
  if (data != null && data.isNotEmpty) {
    return "${data[0].toUpperCase()}${data[1].toUpperCase()}";
  }
  return "";
}

String priceShow(String? data) {
  if (data != null && data.isNotEmpty) {
    double price = double.tryParse(data) ?? 0;
    if (price < 10000) {
      return price.toString();
    }
    if (price >= 10000 && price < 1000000) {
      var newPrice = (price / 1000).toDouble();
      return '${newPrice.toStringAsFixed(7).substring(0, 5)}K';
    }
    if (price >= 1000000 && price < 1000000000) {
      var newPrice = price / 1000000;
      return '${newPrice.toStringAsFixed(7).substring(0, 5)}M';
    }
    if (price >= 1000000000 && price < 1000000000000) {
      var newPrice = price / 1000000000;
      return '${newPrice.toStringAsFixed(10).substring(0, 5)}B';
    } else if (price >= 1000000000000) {
      var newPrice = price / 1000000000000;
      return '${newPrice.toStringAsFixed(20).substring(0, 5)}Q';
    }
  }
  return "0";
}
