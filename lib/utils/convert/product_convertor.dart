import 'package:adret/model/company/index.dart';
import 'package:adret/model/inventory/index.dart';
import 'package:adret/model/product/index.dart';
import 'package:adret/model/user/index.dart';
import 'package:adret/utils/convert/inventory_convertor.dart';

ProductModel productConverter({
  required dynamic data,
}) {
  Map<String, dynamic> productMap = Map<String, dynamic>.from(data);

  if (productMap["creator"] != null) {
    // get the creator
    Map<String, dynamic> creatorMap =
        Map<String, dynamic>.from(productMap["creator"]);
    var user = UserModel.fromJson(creatorMap);
    productMap["creator"] = user;
  }

  if (productMap["company"] != null) {
    // get the company
    Map<String, dynamic> companyMap =
        Map<String, dynamic>.from(productMap["company"]);
    var company = CompanyModel.fromJson(companyMap);
    productMap["company"] = company;
  }

  if (productMap["media"] != null) {
    List<String> media = [];
    if (productMap["media"] != null) {
      for (String mediaData in productMap["media"]) {
        media.add(mediaData);
      }
    }
    productMap["media"] = media;
  }

  if (productMap["inventory"] != null) {
    List<InventoryModel> inventories = [];
    for (var inventoryData in productMap["inventory"]) {
      var inventory = inventoryConverter(data: inventoryData);
      inventories.add(inventory);
    }

    productMap["inventory"] = inventories;
  }

  var product = ProductModel.fromJson(productMap);
  return product;
}
