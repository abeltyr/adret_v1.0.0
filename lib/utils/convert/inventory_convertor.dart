// ignore: file_names
import 'package:adret/model/inventory/index.dart';
import 'package:adret/model/inventory/inventoryVariation/index.dart';
import 'package:adret/model/product/index.dart';

InventoryModel inventoryConverter({
  required dynamic data,
}) {
  Map<String, dynamic> inventoryMap = Map<String, dynamic>.from(data);

  List<InventoryVariation> inventoryVariation = [];

  if (inventoryMap["inventoryVariation"] != null) {
    for (var data in inventoryMap["inventoryVariation"]) {
      inventoryVariation.add(InventoryVariation(
          data: data["data"], title: data["title"], id: data["id"]));
    }

    inventoryMap["inventoryVariation"] = inventoryVariation;
  }

  if (inventoryMap["product"] != null) {
    Map<String, dynamic> productMap =
        Map<String, dynamic>.from(inventoryMap["product"]);
    var product = ProductModel.fromJson(productMap);
    inventoryMap["product"] = product;
  }

  var inventory = InventoryModel.fromJson(inventoryMap);

  return inventory;
}
