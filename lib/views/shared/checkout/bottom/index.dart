import 'dart:io';

import 'package:adret/model/input/index.dart';
import 'package:adret/model/order/index.dart';
import 'package:adret/services/cart/index.dart';
import 'package:adret/services/orders/index.dart';
import 'package:adret/services/product/index.dart';
import 'package:adret/services/products/index.dart';
import 'package:adret/services/products/search.dart';
import 'package:adret/services/summary/index.dart';
import 'package:adret/utils/notification/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutBottom extends StatelessWidget {
  final CartService cartService;
  const CheckoutBottom({super.key, required this.cartService});

  @override
  Widget build(BuildContext context) {
    final orderService = Provider.of<OrderService>(context, listen: false);
    final currentProductService =
        Provider.of<CurrentProductService>(context, listen: false);
    final productService = Provider.of<ProductService>(context, listen: false);
    final searchProductService =
        Provider.of<SearchProductService>(context, listen: false);
    final summaryService = Provider.of<SummaryService>(context, listen: false);

    return Container(
      color: DarkModePlatformTheme.secondBlack,
      padding: EdgeInsets.only(
        top: 10,
        bottom: (MediaQuery.of(context).padding.bottom * 2 / 3) +
            (Platform.isAndroid ? 16 : 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (MediaQuery.of(context).size.width - 50) / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "ETB ${cartService.totalPrice} ",
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      color: DarkModePlatformTheme.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      wordSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${cartService.carts.length} items",
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      color: DarkModePlatformTheme.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      wordSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            width: (MediaQuery.of(context).size.width - 50) / 2,
            child: MainButton(
              onClick: () async {
                cartService.updateLoading(true);
                try {
                  bool error = false;
                  for (var i = 0; i < cartService.carts.length; i++) {
                    double sellingPrice = 0.0;

                    if (cartService.carts[i].sellingPrice.input.runtimeType ==
                        String) {
                      sellingPrice = double.tryParse(
                              cartService.carts[i].sellingPrice.input) ??
                          0;
                    } else {
                      sellingPrice =
                          cartService.carts[i].sellingPrice.input ?? 0;
                    }

                    double minSellingPriceEstimation = double.tryParse(
                            cartService.carts[i].inventory
                                .minSellingPriceEstimation!) ??
                        0;

                    if (sellingPrice < minSellingPriceEstimation) {
                      cartService.updateCart(
                        InputModel(
                            input: cartService.carts[i].sellingPrice.input,
                            errorMessage:
                                AppLocalizations.of(context)!.priceIsToLow,
                            errorStatus: true),
                        cartService.carts[i].amount,
                        i,
                      );
                      error = true;
                    }
                  }
                  if (error) {
                    cartService.updateLoading(false);
                    return;
                  }

                  OrderModel? orderData = await orderService.createOrder(
                      carts: cartService.carts, note: "");
                  for (var cart in cartService.carts) {
                    if (cart.productIndex != null &&
                        cart.inventoryIndex != null) {
                      var product = productService.products[cart.productIndex!];

                      int amount = 1;
                      if (cart.amount.input.runtimeType == String) {
                        amount = int.parse(cart.amount.input);
                      } else {
                        amount = cart.amount.input;
                      }
                      int salesAmount = int.parse(product
                          .inventory![cart.inventoryIndex!].salesAmount!);

                      product.inventory![cart.inventoryIndex!].salesAmount =
                          (salesAmount + amount).toString();

                      int inStock = int.parse(product.inStock ?? "0");

                      product.inStock = (inStock - amount).toString();
                      if (!currentProductService.search) {
                        currentProductService.updateProduct(
                          product,
                          cart.productIndex,
                        );
                        productService.updateProduct(
                          product,
                          cart.productIndex,
                        );
                      } else {
                        currentProductService.searchUpdateProduct(
                          product,
                          cart.productIndex,
                        );
                        productService.updateProductById(
                          product,
                        );
                        searchProductService.updateProduct(
                          product,
                          cart.productIndex,
                        );
                      }
                    }
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  cartService.empty();
                  if (orderData != null) {
                    summaryService.addSummary(orderData);
                  }
                  // ignore: use_build_context_synchronously
                  successNotification(
                    context: context,
                    text: orderData != null
                        // ignore: use_build_context_synchronously
                        ? AppLocalizations.of(context)!.orderCreatedMessage
                        // ignore: use_build_context_synchronously
                        : AppLocalizations.of(context)!
                            .orderCreatedMessageWithNote,
                    duration: Duration(
                      milliseconds: orderData != null ? 2000 : 6000,
                    ),
                  );
                } catch (e) {
                  String errorMessage =
                      AppLocalizations.of(context)!.errorNotification;

                  if (e
                      .toString()
                      .contains("today sales collected and closed by manger")) {
                    errorMessage =
                        AppLocalizations.of(context)!.saleClosedErrorMessage;
                  }
                  errorNotification(context: context, text: errorMessage);
                }
                cartService.updateLoading(false);
              },
              loading: cartService.loading,
              borderRadiusData: 10,
              textFontSize: 22,
              icon: "assets/icons/bold/orderTick.svg",
              color: DarkModePlatformTheme.primaryLight1,
              textColor: DarkModePlatformTheme.primaryDark2,
              title: AppLocalizations.of(context)!.sell,
            ),
          ),
        ],
      ),
    );
  }
}
