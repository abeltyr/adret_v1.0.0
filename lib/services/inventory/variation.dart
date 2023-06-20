import 'package:adret/model/productVariation/index.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class VariationService with ChangeNotifier {
  var hiveVariation = Hive.box<ProductVariationListModel>('productVariations');

  ProductVariationListModel get variations =>
      hiveVariation.get("current", defaultValue: ProductVariationListModel())!;

  List<ProductVariationModel> get selectedVariations => hiveVariation
      .get("current", defaultValue: ProductVariationListModel())!
      .variations
      .where((element) => element.selected)
      .toList();

  Future<void> addVariation(ProductVariationModel newVariation) async {
    var variations = hiveVariation
        .get("current", defaultValue: ProductVariationListModel())!
        .variations;

    var exist = variations.indexWhere((element) {
      return element.title.toLowerCase() == newVariation.title.toLowerCase();
    });
    if (exist < 0) {
      newVariation.selected = selectedVariations.length < 3 ? true : false;
      variations = [...variations, newVariation];
    } else {
      variations[exist].selected = selectedVariations.length < 3 ? true : false;
    }
    hiveVariation.put(
        "current", ProductVariationListModel(variations: variations));
    notifyListeners();
  }

  Future<void> variationSelection(int index, bool selection) async {
    var all = hiveVariation.get("current",
        defaultValue: ProductVariationListModel())!;

    all.variations[index].selected = selection;
    hiveVariation.put("current", all);
    notifyListeners();
  }

  Future<void> removeVariation(int index) async {
    var all = hiveVariation.get("current",
        defaultValue: ProductVariationListModel())!;
    all.variations.removeAt(index);
    hiveVariation.put("current", all);
    notifyListeners();
  }

  Future<void> resetVariation() async {
    var all = hiveVariation.get("current",
        defaultValue: ProductVariationListModel())!;

    for (var i = 0; i < all.variations.length; i++) {
      all.variations[i].selected = false;
    }

    hiveVariation.put("current", all);
    notifyListeners();
  }
}
