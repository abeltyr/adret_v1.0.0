// import 'package:adret/model/inventory/index.dart';
import 'package:adret/model/product/index.dart';
import 'package:adret/model/shared.dart';
import 'package:adret/services/products/actions/fetch_products.dart';
import 'package:flutter/material.dart';

class ProductService with ChangeNotifier {
  List<ProductModel> _products = [
    // ProductModel(
    //   id: "clija8vkx0006obn2tdm555dl",
    //   title: "title",
    //   inStock: "78",
    //   category: "women apparel",
    //   productCode: "test-12345678",
    //   inventory: [
    //     InventoryModel(
    //       maxSellingPriceEstimation: "32312",
    //       id: "213",
    //       available: "2",
    //       initialPrice: "3111",
    //       minSellingPriceEstimation: "3121",
    //       salesAmount: "212",
    //     )
    //   ],
    //   detail: "",
    // ),
    // ProductModel(
    //   id: "clija8vkx0006obn2tdm555dl",
    //   title: "title",
    //   inStock: "78",
    //   category: "123456789012",
    //   productCode: "test-12345678",
    //   inventory: [
    //     InventoryModel(
    //       maxSellingPriceEstimation: "32312",
    //       id: "213",
    //       available: "2",
    //       initialPrice: "3111",
    //       minSellingPriceEstimation: "3121",
    //       salesAmount: "212",
    //     )
    //   ],
    //   detail: "",
    // ),
  ];
  List<ProductModel> _topSellingProducts = [];

  bool _hasSearch = false;
  bool _loading = false;

  bool get hasSearch => _hasSearch;
  bool get loading => _loading;

  void updateHasSearch() {
    _hasSearch = !_hasSearch;
    notifyListeners();
  }

  List<ProductModel> get products => _products;
  List<ProductModel> get topSellingProducts => _topSellingProducts;

  Future<void> addProduct(ProductModel product) async {
    _products = [product, ..._products];
    notifyListeners();
  }

  Future<void> updateProduct(ProductModel product, index) async {
    _products[index] = product;
    notifyListeners();
  }

  Future<void> updateProductById(ProductModel product) async {
    var index = _products.indexWhere((element) => element.id == product.id);
    _products[index] = product;
    notifyListeners();
  }

  void updateLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> loadMoreProducts() async {
    if (!_loading) {
      String? productAfter;
      if (products.isNotEmpty) {
        productAfter = products[products.length - 1].id;
      }
      int fetchSize = 30;
      try {
        List<ProductModel> loadedProducts = await fetchProductsFunction(
          filter: FilterModel(
            limit: fetchSize,
            after: productAfter,
          ),
        );
        _products = [..._products, ...loadedProducts];

        notifyListeners();

        if (loadedProducts.length < fetchSize) {
          return false;
        }
        return true;
      } catch (e) {
        throw Exception("");
      }
    } else {
      return true;
    }
  }

  Future<void> refreshProducts() async {
    if (!_loading) {
      if (products.isEmpty) _loading = true;
      String? productBefore;
      if (products.isNotEmpty) {
        productBefore = products[0].id;
      }
      try {
        List<ProductModel> newProducts = await fetchProductsFunction(
          // soldOut: true,
          filter: FilterModel(
            limit: 30,
            before: productBefore,
          ),
        );
        _products = [...newProducts, ..._products];
        _loading = false;
        notifyListeners();
      } catch (e) {
        _loading = false;
        notifyListeners();
        throw Exception(e);
      }
    }
  }

  Future<void> fetchTopProducts() async {
    try {
      List<ProductModel> newProducts = await fetchProductsFunction(
        topSelling: true,
        filter: FilterModel(
          limit: 10,
        ),
      );

      _topSellingProducts = [...newProducts];
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> searchProducts(String value) async {
    String? productBefore;

    try {
      List<ProductModel> newProducts = await fetchProductsFunction(
        title: value,
        code: value,
        filter: FilterModel(
          limit: 10,
          before: productBefore,
        ),
      );

      _topSellingProducts = [...newProducts];
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
