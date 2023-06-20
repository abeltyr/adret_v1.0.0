import 'package:adret/model/inventory/index.dart';
import 'package:adret/model/product/index.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/bottom/index.dart';
import 'package:adret/widgets/product/price/output/index.dart';
import 'package:adret/widgets/product/inventory/card/inventoryCard/image/index.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  final ProductModel product;
  final InventoryModel inventory;
  final String? media;
  final int inventoryIndex;
  final int? productIndex;
  const InventoryScreen({
    super.key,
    required this.product,
    required this.inventory,
    required this.inventoryIndex,
    required this.productIndex,
    this.media,
  });

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String title = "";
  String value = "";
  int? inventoryMedia;

  @override
  void initState() {
    super.initState();
    getTitle();
  }

  getTitle() {
    if (mounted) {
      var titleData = "";
      var valueData = "";
      if (widget.inventory.inventoryVariation != null) {
        for (var data in widget.inventory.inventoryVariation!) {
          titleData =
              "$titleData${titleData.isEmpty ? '' : ' - '}${capitalize(data.title)}";
          String titleValue = data.data ?? "";
          valueData =
              "$valueData${valueData.isNotEmpty && titleValue.isNotEmpty ? ' - ' : ''}${(titleValue)}";
        }
      }
      setState(() {
        title = titleData;
        value = valueData;
      });
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    if (widget.product.inventory != null && widget.inventory.id != null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 3 > 400
            ? MediaQuery.of(context).size.height / 3
            : 400,
        child: Scaffold(
          backgroundColor: DarkModePlatformTheme.secondBlack,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: 75,
                      height: 5,
                      decoration: BoxDecoration(
                        color: DarkModePlatformTheme.darkWhite,
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child:
                            InventoryCardImage(image: widget.inventory.media),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color:
                                  DarkModePlatformTheme.white.withOpacity(0.5),
                              fontWeight: FontWeight.w200,
                              fontSize: 20,
                              wordSpacing: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            overflow: TextOverflow.clip,
                            value,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color:
                                  DarkModePlatformTheme.white.withOpacity(0.75),
                              fontWeight: FontWeight.w200,
                              fontSize: 18,
                              wordSpacing: 1,
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    child: ProductPriceOutput(
                      maxSellingPriceValue:
                          widget.inventory.maxSellingPriceEstimation ?? "0",
                      minSellingPriceValue:
                          widget.inventory.minSellingPriceEstimation ?? "0",
                      initialPriceValue: widget.inventory.initialPrice ?? "0",
                      sales: widget.inventory.salesAmount ?? "0",
                      totalInventory: widget.inventory.available ?? "0",
                    ),
                  ),
                ],
              ),
              ProductBottom(
                product: widget.product,
                index: widget.productIndex,
                inventoryIndex: widget.inventoryIndex,
              ),
            ],
          ),
        ),
      );
    } else {
      return const Stack();
    }
  }
}
