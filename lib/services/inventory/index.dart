import 'package:adret/model/input/index.dart';
import 'package:adret/model/inventoryInput/index.dart';
import 'package:adret/model/inventoryInputTitle/index.dart';
import 'package:adret/model/productVariation/index.dart';
import 'package:adret/model/productView/index.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InventoryService with ChangeNotifier {
  var hiveProduct = Hive.box<ProductViewModel>('productView');

  List<InventoryInputModel> _inventories = [
    InventoryInputModel(
      amount: InputModel(input: 1),
      sales: 0,
      initialPrice: InputModel(),
      minSellingPriceEstimation: InputModel(),
      maxSellingPriceEstimation: InputModel(),
      title: [],
    ),
  ];
  List<InventoryInputModel> get inventories => _inventories;

  // add the inventory at the start of the screen popup
  Future<int> addInventory(List<ProductVariationModel> titles) async {
    var inventoryTitles = await generateInventoryTitle(-1, titles);

    InventoryInputModel inventoryData = InventoryInputModel(
      amount:
          InputModel(input: _inventories[_inventories.length - 1].amount.input),
      sales: inventories[_inventories.length - 1].sales,
      initialPrice: InputModel(
          input: _inventories[_inventories.length - 1].initialPrice.input),
      minSellingPriceEstimation: InputModel(
          input: _inventories[_inventories.length - 1]
              .minSellingPriceEstimation
              .input),
      maxSellingPriceEstimation: InputModel(
          input: _inventories[_inventories.length - 1]
              .maxSellingPriceEstimation
              .input),
      title: inventoryTitles,
    );

    if (inventoryData.initialPrice.input != null) {
      _inventories = [..._inventories, inventoryData];
    } else {
      _inventories[_inventories.length - 1] = inventoryData;
    }
    return _inventories.length - 1;
  }

// update the state data of an inventory
  Future<void> updateInventory(InventoryInputModel newInventory, int index,
      List<ProductVariationModel>? titles) async {
    if (titles != null) {
      newInventory.title = await generateInventoryTitle(index, titles);
    }
    _inventories[index] = newInventory;
  }

// fetch the inventory from the hive to the state
  Future<ProductViewModel> fetchProduct(
      List<ProductVariationModel>? titles) async {
    List<InventoryInputTitleModel> titlesData = [];
    if (titles != null) {
      titlesData = await generateInventoryTitle(0, titles);
    }
    var product = hiveProduct.get("currentProduct",
        defaultValue: ProductViewModel(
          inventory: [
            InventoryInputModel(
              amount: InputModel(input: 1),
              sales: 0,
              initialPrice: InputModel(),
              minSellingPriceEstimation: InputModel(),
              maxSellingPriceEstimation: InputModel(),
              title: titlesData,
            ),
          ],
        ))!;

    product.inventory ??= [
      InventoryInputModel(
        amount: InputModel(input: 1),
        sales: 0,
        initialPrice: InputModel(),
        minSellingPriceEstimation: InputModel(),
        maxSellingPriceEstimation: InputModel(),
        title: titlesData,
      ),
    ];
    return product;
  }

// fetch the inventory from the hive to the state
  Future<void> fetchInventory(List<ProductVariationModel>? titles) async {
    var product = await fetchProduct(titles);
    if (product.inventory != null && product.inventory!.isNotEmpty) {
      _inventories = product.inventory!;
    }
  }

  Future<void> cleanInventory() async {
    _inventories = [
      InventoryInputModel(
        amount: InputModel(input: 1),
        sales: 0,
        initialPrice: InputModel(),
        minSellingPriceEstimation: InputModel(),
        maxSellingPriceEstimation: InputModel(),
        title: [],
      ),
    ];
  }

// save the state inventory data to the hive
  Future<void> saveInventory() async {
    var product = await fetchProduct(null);
    product.inventory = _inventories;
    hiveProduct.put("currentProduct", product);
    notifyListeners();
  }

  Future<void> removeInventoryState(int index) async {
    if (_inventories.length != 1) {
      _inventories.removeAt(index);
    } else {
      _inventories[0] = InventoryInputModel(
        amount: InputModel(input: 1),
        sales: 0,
        initialPrice: InputModel(),
        minSellingPriceEstimation: InputModel(),
        maxSellingPriceEstimation: InputModel(),
        title: [],
      );
    }
    notifyListeners();
  }

  Future<void> removeInventoryHive(int index) async {
    var product = await fetchProduct(null);

    if (product.inventory!.length != 1 && product.inventory!.length > index) {
      product.inventory!.removeAt(index);
    } else if (product.inventory!.length == 1) {
      product.inventory![0] = InventoryInputModel(
        amount: InputModel(input: 1),
        sales: 0,
        initialPrice: InputModel(),
        minSellingPriceEstimation: InputModel(),
        maxSellingPriceEstimation: InputModel(),
        title: [],
      );
      _inventories[0] = InventoryInputModel(
        amount: InputModel(input: 1),
        sales: 0,
        initialPrice: InputModel(),
        minSellingPriceEstimation: InputModel(),
        maxSellingPriceEstimation: InputModel(),
        title: [],
      );
    } else {}
    hiveProduct.put("currentProduct", product);
  }

  Future<bool> validateInventory(
    InventoryInputModel inventory,
    Function(String text) errorNotification,
    BuildContext context,
  ) async {
    double? initialPrice;
    if (inventory.initialPrice.input != null) {
      initialPrice = double.tryParse(inventory.initialPrice.input);
    }
    if (initialPrice == null) {
      errorNotification(
        AppLocalizations.of(context)!.buyingPriceError,
      );

      return false;
    }

    double? minSellingPriceEstimation;
    if (inventory.minSellingPriceEstimation.input != null &&
        inventory.minSellingPriceEstimation.input.runtimeType == String) {
      minSellingPriceEstimation =
          double.tryParse(inventory.minSellingPriceEstimation.input);
    } else if (inventory.minSellingPriceEstimation.input != null) {
      minSellingPriceEstimation = inventory.minSellingPriceEstimation.input;
    }
    if (minSellingPriceEstimation == null) {
      errorNotification(
        AppLocalizations.of(context)!.minSellingPriceError,
      );
      return false;
    }
    if (minSellingPriceEstimation < initialPrice) {
      errorNotification(
        AppLocalizations.of(context)!.minInitialValidationError,
      );
      return false;
    }

    double? maxSellingPriceEstimation;
    if (inventory.maxSellingPriceEstimation.input != null &&
        inventory.maxSellingPriceEstimation.input.runtimeType == String) {
      maxSellingPriceEstimation =
          double.tryParse(inventory.maxSellingPriceEstimation.input);
    } else if (inventory.maxSellingPriceEstimation.input != null) {
      maxSellingPriceEstimation = inventory.maxSellingPriceEstimation.input;
    }

    if (maxSellingPriceEstimation == null) {
      errorNotification(
        AppLocalizations.of(context)!.maxSellingPriceError,
      );
      return false;
    }
    if (minSellingPriceEstimation > maxSellingPriceEstimation) {
      errorNotification(
        AppLocalizations.of(context)!.minMaxValidationError,
      );
      return false;
    }
    return true;
  }

// generate the needed title of the product
  Future<List<InventoryInputTitleModel>> generateInventoryTitle(
      int index, List<ProductVariationModel> titles) async {
    InventoryInputModel? inventoryData;
    if (index >= 0) {
      inventoryData = inventories[index];
    }

    List<InventoryInputTitleModel> newTitles = [];
    for (var i = 0; i < titles.length; i++) {
      InputModel valueData = InputModel(input: "");
      if (inventoryData != null &&
          inventoryData.title != null &&
          inventoryData.title!.length - 1 >= i) {
        valueData = inventoryData.title![i].value;
      }
      newTitles = [
        ...newTitles,
        InventoryInputTitleModel(
          title: titles[i].title,
          value: valueData,
        )
      ];
    }
    return newTitles;
  }
}
