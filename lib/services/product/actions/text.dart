import 'package:adret/model/input/index.dart';
import 'package:adret/model/productView/index.dart';
import 'package:hive_flutter/hive_flutter.dart';

var hiveProduct = Hive.box<ProductViewModel>('productView');

void updateTitle({required String data}) {
  ProductViewModel? hiveData =
      hiveProduct.get("currentProduct", defaultValue: ProductViewModel());
  InputModel title = hiveData!.title ?? InputModel();
  if (data.isNotEmpty &&
      (title.input == null || (title.input != null && title.input!.isEmpty))) {
    title.errorStatus = false;
    title.errorMessage = "";
  }

  hiveData.title ??= title;
  hiveData.title!.input = data;

  hiveProduct.put("currentProduct", hiveData);
}

void updateDetail({required String data}) {
  ProductViewModel? hiveData =
      hiveProduct.get("currentProduct", defaultValue: ProductViewModel());
  InputModel detail = hiveData!.detail ?? InputModel();

  hiveData.detail ??= detail;
  hiveData.detail!.input = data;

  hiveProduct.put("currentProduct", hiveData);
}
