import 'dart:math';

import 'package:adret/model/cart/index.dart';
import 'package:adret/model/input/index.dart';
import 'package:flutter/material.dart';

class CartService with ChangeNotifier {
  List<CartModel> _carts = [
    // CartModel(
    //   amount: InputModel(input: 2),
    //   inventory: InventoryModel(
    //       available: "10000",
    //       salesAmount: "0",
    //       inventoryVariation: [
    //         InventoryVariation(
    //           data: "green",
    //           id: "sad",
    //           title: "color",
    //         ),
    //         InventoryVariation(
    //           data: "43",
    //           id: "sad",
    //           title: "size",
    //         ),
    //         InventoryVariation(
    //           data: "green",
    //           id: "sad",
    //           title: "color",
    //         ),
    //       ]),
    //   productCode: "@@!@",
    //   sellingPrice: InputModel(input: 2),
    //   title: "das",
    //   totalPrice: 828,
    //   inventoryIndex: 2,
    //   productIndex: 2,
    // ),
  ];

  List<CartModel> get carts => _carts;
  double _totalPrice = 0;

  double get totalPrice => _totalPrice;

  bool _loading = false;
  bool get loading => _loading;

  void updateLoading(bool data) {
    _loading = data;
    notifyListeners();
  }

  void empty() {
    _carts = [];
    notifyListeners();
  }

  Future<void> addCart(CartModel cart) async {
    int? countIndex;
    int count = 0;
    for (var cartData in _carts) {
      if (cartData.inventory.id == cart.inventory.id) {
        countIndex = count;
      }
      count++;
    }
    if (countIndex == null) {
      _carts.add(cart);
    } else {
      _carts[countIndex] = setData(_carts[countIndex]);
    }
    getTotal();
    notifyListeners();
  }

  Future<void> updateCart(
    InputModel sellingPrice,
    InputModel amount,
    int index,
  ) async {
    _carts[index].totalPrice = cartTotalPrice(
      amountData: amount.input,
      sellingPriceData: sellingPrice.input,
    );
    _carts[index].sellingPrice = sellingPrice;
    _carts[index].amount = amount;
    getTotal();
    notifyListeners();
  }

  Future<void> removeCart(int index) async {
    _carts.removeAt(index);
    getTotal();
    notifyListeners();
  }

  Future<void> getTotal() async {
    double totalPrice = 0;
    for (var data in _carts) {
      totalPrice = data.totalPrice + totalPrice;
    }
    _totalPrice = totalPrice;
  }

  CartModel setData(CartModel cartData) {
    CartModel updatedCart = cartData;
    int amount = 0;
    if (updatedCart.amount.input != null &&
        updatedCart.amount.input.runtimeType == String) {
      amount = int.tryParse(updatedCart.amount.input) ?? 1;
    } else if (updatedCart.amount.input != null &&
            updatedCart.amount.input.runtimeType == double ||
        updatedCart.amount.input.runtimeType == int) {
      amount = updatedCart.amount.input;
    }
    int available = int.tryParse(updatedCart.inventory.available!) ?? 0;
    int sale = int.tryParse(updatedCart.inventory.salesAmount!) ?? 0;
    int left = available - sale;
    if (left > amount) {
      updatedCart.amount.input = amount + 1;
    } else {
      updatedCart.amount.input = left;
    }

    double? sellingPrice;

    if (updatedCart.sellingPrice.input.runtimeType == String) {
      sellingPrice = double.tryParse(updatedCart.sellingPrice.input);
    } else if (updatedCart.sellingPrice.input.runtimeType == double ||
        updatedCart.sellingPrice.input.runtimeType == int) {
      sellingPrice = updatedCart.sellingPrice.input;
    }

    if (sellingPrice != null) {
      updatedCart.sellingPrice.input = sellingPrice;
      updatedCart.totalPrice = cartTotalPrice(
        amountData: updatedCart.amount.input,
        sellingPriceData: sellingPrice,
      );
    }

    return updatedCart;
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  double cartTotalPrice(
      {required dynamic amountData, required dynamic sellingPriceData}) {
    int amount = 1;
    if (amountData.runtimeType == String) {
      amount = int.tryParse(amountData) ?? 1;
    } else if (sellingPriceData.runtimeType == double) {
      amount = amountData.toInt();
    } else {
      amount = amountData;
    }
    double sellingPrice = 1;
    if (sellingPriceData.runtimeType == String) {
      sellingPrice = double.tryParse(sellingPriceData) ?? 1;
    } else if (sellingPriceData.runtimeType == int) {
      sellingPrice = sellingPriceData.toDouble();
    } else {
      sellingPrice = sellingPriceData;
    }

    return roundDouble(sellingPrice * amount, 2);
  }
}
