import 'package:adret/model/sales/index.dart';
import 'package:adret/model/user/index.dart';
import 'package:adret/utils/convert/inventory_convertor.dart';

SalesModel saleConverter({
  required dynamic data,
}) {
  Map<String, dynamic> salesMap = Map<String, dynamic>.from(data);

  if (salesMap["inventory"] != null) {
    var inventory = inventoryConverter(data: salesMap["inventory"]);
    salesMap["inventory"] = inventory;
  }

  if (salesMap["seller"] != null) {
    Map<String, dynamic> userMap =
        Map<String, dynamic>.from(salesMap["seller"]);
    var user = UserModel.fromJson(userMap);
    salesMap["seller"] = user;
  }

  var sale = SalesModel.fromJson(salesMap);
  return sale;
}
