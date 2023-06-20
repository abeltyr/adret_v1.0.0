import 'package:adret/model/product/index.dart';
import 'package:adret/model/shared.dart';
import 'package:adret/services/products/actions/fetch_products.dart';
import 'package:flutter/material.dart';

class SearchProductService with ChangeNotifier {
  List<ProductModel> _searchProducts = [];
  String _searchText = "";

  bool _loading = false;

  String get searchText => _searchText;

  bool get loading => _loading;

  List<ProductModel> get searchProducts => _searchProducts;

  void updateLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void updateSearch(String value) {
    _searchText = value;
  }

  Future<void> search(String text) async {
    _loading = true;
    notifyListeners();
    try {
      List<ProductModel> searchProduct = await fetchProductsFunction(
        filter: FilterModel(
          limit: 30,
        ),
        code: text,
        title: text,
      );
      _searchProducts = [...searchProduct];
    } catch (e) {
      throw Exception(e);
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> refreshProducts() async {
    if (!_loading) {
      if (_searchProducts.isEmpty) _loading = true;
      String? productBefore;
      if (_searchProducts.isNotEmpty) {
        productBefore = _searchProducts[0].id;
      }
      try {
        List<ProductModel> newProducts = await fetchProductsFunction(
          filter: FilterModel(
            limit: 30,
            before: productBefore,
          ),
          code: _searchText,
          title: _searchText,
        );
        _searchProducts = [...newProducts, ..._searchProducts];
      } catch (e) {
        throw Exception("");
      }
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> loadMoreProducts() async {
    String? productAfter;
    if (_searchProducts.isNotEmpty) {
      productAfter = _searchProducts[_searchProducts.length - 1].id;
    }
    int fetchSize = 30;
    try {
      List<ProductModel> loadedProducts = await fetchProductsFunction(
        filter: FilterModel(
          limit: fetchSize,
          after: productAfter,
        ),
        code: _searchText,
        title: _searchText,
      );
      _searchProducts = [..._searchProducts, ...loadedProducts];

      notifyListeners();

      if (loadedProducts.length < fetchSize) {
        return false;
      }
      return true;
    } catch (e) {
      throw Exception("");
    }
  }

  Future<void> updateProduct(ProductModel product, index) async {
    _searchProducts[index] = product;
    notifyListeners();
  }
}
