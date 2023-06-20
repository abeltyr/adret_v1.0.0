import 'package:adret/model/input/index.dart';
import 'package:adret/model/productView/index.dart';
import 'package:hive_flutter/hive_flutter.dart';

var hiveProduct = Hive.box<ProductViewModel>('productView');

void updateCategory({required String data}) {
  ProductViewModel? hiveData =
      hiveProduct.get("currentProduct", defaultValue: ProductViewModel());

  InputModel category = hiveData!.category ?? InputModel();

  category.input = data;
  hiveData.category = category;
  hiveProduct.put("currentProduct", hiveData);
}
