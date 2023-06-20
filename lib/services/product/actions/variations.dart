import 'package:adret/model/productView/index.dart';
import 'package:hive/hive.dart';

var hiveProduct = Hive.box<ProductViewModel>('productView');

void updateProductVariation({required String value}) {
  ProductViewModel hiveData =
      hiveProduct.get("currentProduct", defaultValue: ProductViewModel())!;

  List<String> productVariationData = hiveData.productVariation ?? [];

  if (!productVariationData.contains(value)) {
    productVariationData = [...productVariationData, value];
    hiveData.productVariation = productVariationData;
  } else {
    productVariationData.remove(value);
    hiveData.productVariation = productVariationData;
  }

  hiveProduct.put("currentProduct", hiveData);
}
