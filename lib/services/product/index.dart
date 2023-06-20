import 'package:adret/model/product/index.dart';
import 'package:adret/model/productVariation/index.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CurrentProductService with ChangeNotifier {
  ProductModel _product = ProductModel(
      // id: "1",
      // title: "title",
      // inStock: "78",
      // category: "Cloth",
      // productCode: "1233",
      // inventory: [
      //   InventoryModel(
      //     maxSellingPriceEstimation: "32312",
      //     id: "213",
      //   ),
      //   InventoryModel(
      //     maxSellingPriceEstimation: "32312",
      //     id: "213",
      //   )
      // ],
      // detail: "",
      );
  bool _search = false;
  ProductModel get product => _product;
  bool get search => _search;

  var hiveVariation = Hive.box<ProductVariationListModel>('productVariations');

  int? _index;
  int? get index => _index;
  Future<void> updateProduct(ProductModel productData, int? index) async {
    _product = productData;
    if (index != null) _index = index;
    _search = false;
    notifyListeners();
  }

  Future<void> searchUpdateProduct(ProductModel productData, int? index) async {
    _product = productData;
    if (index != null) _index = index;
    _search = true;
    notifyListeners();
  }
}
