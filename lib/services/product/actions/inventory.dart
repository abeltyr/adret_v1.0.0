import 'package:adret/model/inventoryInput/index.dart';
import 'package:adret/model/productView/index.dart';
import 'package:hive_flutter/hive_flutter.dart';

var hiveProduct = Hive.box<ProductViewModel>('productView');

void updateInventory({required InventoryInputModel data}) {
  ProductViewModel? hiveData =
      hiveProduct.get("currentProduct", defaultValue: ProductViewModel());
  List<InventoryInputModel> inventory = hiveData!.inventory ?? [];

  inventory = [data];

  hiveData.inventory = inventory;

  hiveProduct.put("currentProduct", hiveData);
}
