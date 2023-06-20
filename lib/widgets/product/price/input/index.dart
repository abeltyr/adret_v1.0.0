import 'package:adret/model/input/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/price/input/header/index.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductPriceInput extends StatefulWidget {
  final Function(String) initialPriceFunction;
  final Color backgroundColor;
  final Function(
    InputModel,
    InputModel,
  ) sellingPriceFunction;
  final InputModel initialPriceValue;
  final InputModel minSellingPriceValue;
  final InputModel maxSellingPriceValue;
  const ProductPriceInput({
    super.key,
    this.backgroundColor = DarkModePlatformTheme.secondBlack,
    required this.initialPriceFunction,
    required this.sellingPriceFunction,
    required this.initialPriceValue,
    required this.minSellingPriceValue,
    required this.maxSellingPriceValue,
  });

  @override
  State<ProductPriceInput> createState() => _ProductPriceInputState();
}

class _ProductPriceInputState extends State<ProductPriceInput> {
  InputModel minPrice = InputModel(input: 0);
  InputModel maxPrice = InputModel(input: 100);
  late TextEditingController _initialPriceController;
  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;
  bool range = false;

  @override
  void initState() {
    super.initState();
    double initialPriceValue = 0;
    _minPriceController = TextEditingController();
    _maxPriceController = TextEditingController();
    if (widget.initialPriceValue.input != null) {
      initialPriceValue = double.tryParse(widget.initialPriceValue.input) ?? 0;
      minPrice = InputModel(input: initialPriceValue);
      _minPriceController =
          TextEditingController(text: initialPriceValue.toStringAsFixed(1));
      _minPriceController.text = initialPriceValue.toString();
      _maxPriceController = TextEditingController(
          text: ((initialPriceValue + 10) * 4).toStringAsFixed(1));
    }

    _initialPriceController = TextEditingController(
      text: initialPriceValue > 0 ? initialPriceValue.toString() : "",
    );

    if (widget.minSellingPriceValue.input != null) {
      minPrice = widget.minSellingPriceValue;
      _minPriceController = TextEditingController(
          text: widget.minSellingPriceValue.input.toString());
    }

    if (widget.maxSellingPriceValue.input != null) {
      maxPrice = widget.maxSellingPriceValue;
      _maxPriceController = TextEditingController(
          text: widget.maxSellingPriceValue.input.toString());
    }

    if (widget.minSellingPriceValue.input != null &&
        widget.maxSellingPriceValue.input != null &&
        widget.maxSellingPriceValue.input !=
            widget.minSellingPriceValue.input) {
      setState(() {
        range = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _initialPriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.backgroundColor,
      ),
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 5,
        top: 10,
      ),
      child: Column(
        children: [
          PriceHeader(
            range: range,
            rangeClick: () {
              setState(() {
                range = !range;
              });
              if (range) {
                double iPrice =
                    double.tryParse(_initialPriceController.text) ?? 0;
                double min = (iPrice * 1.05).roundToDouble();
                minPrice = InputModel(
                    input: min,
                    errorMessage: minPrice.errorMessage,
                    errorStatus: minPrice.errorStatus);
                _minPriceController.text = min.toStringAsFixed(1);
                widget.sellingPriceFunction(minPrice, maxPrice);
              } else {
                widget.sellingPriceFunction(maxPrice, maxPrice);
              }
            },
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            thickness: 0.4,
            color: DarkModePlatformTheme.white.withOpacity(0.3),
          ),
          const SizedBox(
            height: 4,
          ),
          LayoutBuilder(builder: (context, snapshot) {
            return Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: range ? snapshot.maxWidth : snapshot.maxWidth / 2,
                  child: Input(
                    textInputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    valueSetter: () {
                      return widget.initialPriceValue;
                    },
                    onChanged: (value) {
                      widget.initialPriceFunction(value);
                      widget.sellingPriceFunction(minPrice, maxPrice);
                    },
                    controller: _initialPriceController,
                    icon: "assets/icons/moneySend.svg",
                    label: AppLocalizations.of(context)!.buyingPrice,
                    ratio1: range ? 0.8 : 1.4,
                    ratio2: range ? 11.2 : 10.6,
                    size: range ? 22 : 20,
                    divider: range,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: range ? 0 : snapshot.maxWidth / 2,
                  child: Input(
                    textInputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    valueSetter: () {
                      return widget.initialPriceValue;
                    },
                    onChanged: (value) {
                      double? price = double.tryParse(value);
                      minPrice = InputModel(
                        input: price,
                      );
                      maxPrice = InputModel(
                        input: price,
                      );
                      widget.sellingPriceFunction(minPrice, maxPrice);
                    },
                    controller: _maxPriceController,
                    icon: "assets/icons/moneyReceive.svg",
                    label: AppLocalizations.of(context)!.sellingPrice,
                    ratio1: 1.4,
                    ratio2: 10.6,
                    size: 20,
                  ),
                )
              ],
            );
          }),
          const SizedBox(
            height: 12,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 200),
            child: !range
                ? const Stack()
                : LayoutBuilder(
                    builder: (context, snapshot) {
                      return Row(children: [
                        SizedBox(
                          width: snapshot.maxWidth / 2,
                          child: Input(
                            divider: true,
                            paddingData: 5,
                            ratio1: 1.5,
                            ratio2: 10.5,
                            icon: "assets/icons/moneyReceive.svg",
                            label:
                                AppLocalizations.of(context)!.minSellingPrice,
                            size: 18,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                    decimal: true),
                            controller: _minPriceController,
                            valueSetter: () {
                              return minPrice;
                            },
                            onChanged: (p0) {
                              double? start = double.tryParse(p0);

                              if (p0 != "" && double.tryParse(p0) == null) {
                                _minPriceController.text =
                                    start != null ? start.toString() : "";
                                _minPriceController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                  offset: _minPriceController.text.length,
                                ));
                              }
                              minPrice = InputModel(
                                input: start,
                              );
                              widget.sellingPriceFunction(minPrice, maxPrice);
                            },
                          ),
                        ),
                        SizedBox(
                          width: snapshot.maxWidth / 2,
                          child: Input(
                            divider: true,
                            paddingData: 5,
                            ratio1: 1.5,
                            ratio2: 10.5,
                            icon: "assets/icons/moneyReceive.svg",
                            label:
                                AppLocalizations.of(context)!.maxSellingPrice,
                            size: 18,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                    decimal: true),
                            controller: _maxPriceController,
                            valueSetter: () {
                              return maxPrice;
                            },
                            onChanged: (p0) {
                              double? end = double.tryParse(p0);
                              if (p0 != "" && double.tryParse(p0) == null) {
                                _maxPriceController.text =
                                    end != null ? end.toString() : "";
                                _maxPriceController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                  offset: _maxPriceController.text.length,
                                ));
                              }
                              maxPrice = InputModel(
                                input: end,
                              );
                              widget.sellingPriceFunction(minPrice, maxPrice);
                            },
                          ),
                        ),
                      ]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
