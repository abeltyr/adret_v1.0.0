import 'package:flutter/material.dart';

class NavbarModel {
  int index;
  String activeIcon;
  String icon;
  String title;
  Widget? modal;
  String? path;

  NavbarModel({
    required this.index,
    required this.activeIcon,
    required this.icon,
    required this.title,
    this.modal,
    this.path,
  });
}

class FilterModel {
  int? limit;
  String? after;
  String? before;

  FilterModel({
    this.limit,
    this.after,
    this.before,
  });

  Map<String, dynamic> toMap() {
    return {
      'after': after,
      'before': before,
      'limit': limit,
    };
  }
}

class InventoryOutputModel {
  String title;
  double initialPrice;
  double minSellingPriceEstimation;
  double maxSellingPriceEstimation;
  int amount;

  InventoryOutputModel({
    required this.title,
    required this.initialPrice,
    required this.minSellingPriceEstimation,
    required this.maxSellingPriceEstimation,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'initialPrice': initialPrice,
      'minSellingPriceEstimation': minSellingPriceEstimation,
      'maxSellingPriceEstimation': maxSellingPriceEstimation,
      'amount': amount,
    };
  }
}
