import 'package:adret/model/input/index.dart';
import 'package:adret/model/inventory/inventoryVariation/index.dart';
import 'package:adret/services/cart/index.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/card/tag/index.dart';
import 'package:adret/widgets/product/amount/index.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutPrice extends StatefulWidget {
  final int index;
  const CheckoutPrice({
    super.key,
    required this.index,
  });

  @override
  State<CheckoutPrice> createState() => _CheckoutPriceState();
}

class _CheckoutPriceState extends State<CheckoutPrice> {
  late TextEditingController _sellingController;
  late FocusNode _sellingFocus;
  int? maxAmount;
  List<InventoryVariation> inventoryVariation = [];

  String? price;
  @override
  void initState() {
    super.initState();
    final cartService = Provider.of<CartService>(context, listen: false);
    String value =
        cartService.carts[widget.index].sellingPrice.input.toString();
    _sellingController = TextEditingController(text: value);
    _sellingFocus = FocusNode();

    int available =
        int.parse(cartService.carts[widget.index].inventory.available ?? "0");
    int sales =
        int.parse(cartService.carts[widget.index].inventory.salesAmount ?? "0");

    maxAmount = available - sales;

    inventoryVariation =
        cartService.carts[widget.index].inventory.inventoryVariation ?? [];

    inventoryVariation = [
      InventoryVariation(data: "$maxAmount", title: "inStock", id: ""),
      ...inventoryVariation
    ];
    price = cartService.carts[widget.index].sellingPrice.input.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _sellingController.dispose();
    _sellingFocus.dispose();
  }

  @override
  void didUpdateWidget(covariant CheckoutPrice oldWidget) {
    super.didUpdateWidget(oldWidget);

    final cartService = Provider.of<CartService>(context, listen: false);

    if (price != null &&
        price !=
            cartService.carts[widget.index].sellingPrice.input.toString()) {
      _sellingController.text =
          cartService.carts[widget.index].sellingPrice.input.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context, listen: false);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width - 30,
          child: Wrap(
            spacing: 8,
            runSpacing: 10,
            children: inventoryVariation.map((value) {
              if (value.title == "inStock") {
                return SizedBox(
                  width: 30 +
                      ((value.data ?? "").length *
                          ((value.data ?? "").length < 3 ? 7 : 8)),
                  child: TagCard(
                    icon: "assets/icons/bold/box.svg",
                    text: value.data ?? "",
                  ),
                );
              } else {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                      color:
                          DarkModePlatformTheme.accentLight3.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(3.5)),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${value.title == "InStocks Data" ? 'InStock' : capitalize(value.title)}: ${value.data}',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        color: DarkModePlatformTheme.white,
                        fontWeight: FontWeight.w100,
                        fontSize: 14,
                        wordSpacing: 1,
                      ),
                    ),
                  ),
                );
              }
            }).toList(),
          ),
        ),
        const Divider(
          height: 2,
          color: DarkModePlatformTheme.white,
        ),
        const SizedBox(
          height: 10,
        ),
        LayoutBuilder(builder: (context, snapshot) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: (snapshot.maxWidth * 2 / 3) - 6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.etb,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: DarkModePlatformTheme.white.withOpacity(0.75),
                        fontWeight: FontWeight.w200,
                        fontSize: '${Localizations.localeOf(context)}' == "en"
                            ? 20
                            : 16,
                        wordSpacing: 1,
                      ),
                    ),
                    Expanded(
                      child: Input(
                        label: AppLocalizations.of(context)!.sellingPrice,
                        controller: _sellingController,
                        valueSetter: () {
                          return cartService.carts[widget.index].sellingPrice;
                        },
                        focus: _sellingFocus,
                        requiredField: true,
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          double? sellingData = double.tryParse(value);

                          if (value != "" && sellingData == null) {
                            _sellingController.text = cartService
                                .carts[widget.index].sellingPrice.input
                                .toString();
                            _sellingController.selection =
                                TextSelection.fromPosition(TextPosition(
                              offset: _sellingController.text.length,
                            ));
                            price = _sellingController.text;
                            return;
                          }

                          String sellingPriceData = "";
                          if (value == "") {
                            _sellingController.text = cartService
                                .carts[widget.index]
                                .inventory
                                .minSellingPriceEstimation!;
                            _sellingController.selection =
                                TextSelection.fromPosition(TextPosition(
                              offset: _sellingController.text.length,
                            ));
                            sellingPriceData = cartService.carts[widget.index]
                                .inventory.minSellingPriceEstimation!;
                            sellingData = double.tryParse(
                              cartService.carts[widget.index].inventory
                                      .minSellingPriceEstimation ??
                                  "0",
                            );
                          } else {
                            cartService.carts[widget.index].sellingPrice.input =
                                value;
                            sellingPriceData = sellingData!.toStringAsFixed(1);
                          }
                          price = sellingPriceData;
                          cartService.updateCart(
                            InputModel(
                              input: sellingPriceData,
                            ),
                            cartService.carts[widget.index].amount,
                            widget.index,
                          );
                        },
                        color: DarkModePlatformTheme.white.withOpacity(0.75),
                        size: 16,
                        borderPadding: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                width: (snapshot.maxWidth / 3) - 6,
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${cartService.carts[widget.index].totalPrice} ${AppLocalizations.of(context)!.etb}",
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: DarkModePlatformTheme.white.withOpacity(0.75),
                      fontWeight: FontWeight.w200,
                      fontSize: '${Localizations.localeOf(context)}' == "en"
                          ? 20
                          : 16,
                      wordSpacing: 1,
                    ),
                  ),
                ),
              )
            ],
          );
        }),
        const SizedBox(
          height: 8,
        ),
        ProductAmountInput(
          amountFunction: (value) {
            cartService.updateCart(
              cartService.carts[widget.index].sellingPrice,
              InputModel(input: value),
              widget.index,
            );
          },
          maxAmount: maxAmount,
          amount: cartService.carts[widget.index].amount,
        ),
      ],
    );
  }
}
