import 'dart:io';

import 'package:adret/model/cart/index.dart';
import 'package:adret/model/input/index.dart';
import 'package:adret/model/product/index.dart';
import 'package:adret/services/cart/index.dart';
import 'package:adret/utils/notification/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/checkout/index.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductBottom extends StatelessWidget {
  final ProductModel product;
  final int? index;
  final int inventoryIndex;
  const ProductBottom(
      {super.key, required this.product, this.index, this.inventoryIndex = 0});

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context, listen: false);
    final media = product.inventory![inventoryIndex].media ??
        (product.media != null && product.media!.isNotEmpty
            ? product.media![0]
            : null);

    return Positioned(
      bottom:
          MediaQuery.of(context).padding.bottom + (Platform.isAndroid ? 16 : 0),
      right: 20,
      left: 20,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: product.id != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 55,
                    child: MainButton(
                      onClick: () {
                        int available = int.tryParse(product
                                .inventory![inventoryIndex].available!) ??
                            0;
                        int sale = int.tryParse(product
                                .inventory![inventoryIndex].salesAmount!) ??
                            0;
                        int left = available - sale;

                        if (left > 0) {
                          cartService.addCart(
                            CartModel(
                              amount: InputModel(input: 1),
                              inventory: product.inventory![inventoryIndex],
                              productCode: product.productCode!,
                              title: product.title!,
                              sellingPrice: InputModel(
                                  input: double.tryParse(product
                                      .inventory![inventoryIndex]
                                      .maxSellingPriceEstimation!)),
                              totalPrice: double.tryParse(product
                                  .inventory![inventoryIndex]
                                  .maxSellingPriceEstimation!)!,
                              media: media,
                              productIndex: index,
                              inventoryIndex: inventoryIndex,
                            ),
                          );
                          if (product.inventory != null &&
                              product.inventory!.length > 1) {
                            Navigator.pop(
                              context,
                            );
                          }

                          showCupertinoModalBottomSheet(
                            enableDrag: false,
                            context: context,
                            backgroundColor: DarkModePlatformTheme.secondBlack,
                            builder: (context) => const CheckoutScreen(),
                          );
                        } else {
                          errorNotification(
                            context: context,
                            text: AppLocalizations.of(context)!.outOfStock,
                            bottom: 0,
                          );
                        }
                      },
                      horizontalPadding: 10,
                      borderRadiusData: 10,
                      textFontSize: 30,
                      textFontWeight: FontWeight.w400,
                      color: DarkModePlatformTheme.primaryLight3,
                      textColor: DarkModePlatformTheme.primaryDark2,
                      icon: "assets/icons/bold/orderTick.svg",
                      // title: "Sell",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 55,
                    child: MainButton(
                      onClick: () {
                        int available = int.tryParse(product
                                .inventory![inventoryIndex].available!) ??
                            0;
                        int sale = int.tryParse(product
                                .inventory![inventoryIndex].salesAmount!) ??
                            0;
                        int left = available - sale;

                        if (left > 0) {
                          cartService.addCart(
                            CartModel(
                              amount: InputModel(input: 1),
                              inventory: product.inventory![inventoryIndex],
                              productCode: product.productCode!,
                              title: product.title!,
                              sellingPrice: InputModel(
                                  input: double.tryParse(product
                                      .inventory![inventoryIndex]
                                      .maxSellingPriceEstimation!)),
                              totalPrice: double.tryParse(product
                                  .inventory![inventoryIndex]
                                  .maxSellingPriceEstimation!)!,
                              media: media,
                              productIndex: index,
                              inventoryIndex: inventoryIndex,
                            ),
                          );
                          successNotification(
                            context: context,
                            text: AppLocalizations.of(context)!.cartAdded,
                            bottom: 0,
                          );
                        } else {
                          errorNotification(
                            context: context,
                            text: AppLocalizations.of(context)!.outOfStock,
                            bottom: 0,
                          );
                        }
                      },
                      horizontalPadding: 10,
                      borderRadiusData: 10,
                      textFontSize: 30,
                      textFontWeight: FontWeight.w400,
                      color: DarkModePlatformTheme.accentLight3,
                      textColor: DarkModePlatformTheme.accentDark2,
                      icon: "assets/icons/bold/addCart.svg",
                      // title: "Add",
                    ),
                  ),
                ],
              )
            : const Stack(),
      ),
    );
  }
}
