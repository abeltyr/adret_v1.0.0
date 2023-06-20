import 'package:adret/model/input/index.dart';
import 'package:adret/utils/input_check.dart';
import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductAmountInput extends StatefulWidget {
  final InputModel amount;
  final Function(String) amountFunction;
  final int minAmount;
  final int? maxAmount;
  const ProductAmountInput({
    super.key,
    required this.amountFunction,
    required this.amount,
    this.minAmount = 1,
    this.maxAmount,
  });

  @override
  State<ProductAmountInput> createState() => _ProductAmountInputState();
}

class _ProductAmountInputState extends State<ProductAmountInput> {
  late TextEditingController _amountController;
  late Function onChange;
  late FocusNode _amountFocus;

  String textData = "1";
  InputModel amount = InputModel();

  double fontSize = 22;

  @override
  void didUpdateWidget(covariant ProductAmountInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (amount.input != widget.amount.input) {
      textData = widget.amount.input != null
          ? widget.amount.input.toString()
          : "${widget.minAmount}";
      _amountController = TextEditingController(
        text: textData,
      );
      _amountController.selection = TextSelection.fromPosition(TextPosition(
        offset: _amountController.text.length,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    textData = widget.amount.input != null
        ? widget.amount.input.toString()
        : "${widget.minAmount}";

    _amountController = TextEditingController(
      text: textData,
    );
    amount = InputModel(input: textData);
    _amountFocus = FocusNode();
    _amountFocus.addListener(() {
      if (!_amountFocus.hasFocus) {
        int intValue = int.tryParse(_amountController.text) ?? 1;

        if (intValue < 1) {
          _amountController.text = "1";
          saveData();
        } else if (intValue < widget.minAmount) {
          _amountController.text = "${widget.minAmount}";
          saveData();
        } else if (_amountController.text.isEmpty) {
          _amountController.text = amount.input;
          saveData();
        }
      }
    });
  }

  saveData() {
    _amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _amountController.text.length));
    textData = "${widget.minAmount}";
    widget.amountFunction(_amountController.text);
    amount = InputModel(input: _amountController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _amountFocus.removeListener(
      () {},
    );
    _amountFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (isDouble(_amountController.text)) {
                    double? data = double.tryParse(_amountController.text);
                    if (data! > widget.minAmount) {
                      _amountController.value =
                          TextEditingValue(text: "${(data - 1).toInt()}");
                      setState(() {});
                    } else {
                      _amountController.text = "${widget.minAmount}";
                    }
                  } else {
                    _amountController.text = "${widget.minAmount}";
                  }
                  textData = _amountController.text;
                  _amountController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _amountController.text.length));
                  widget.amountFunction(_amountController.text);
                  amount = InputModel(input: _amountController.text);
                },
                child: Container(
                  width: 45,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DarkModePlatformTheme.white,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/minus.svg",
                    color: DarkModePlatformTheme.secondBlack,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: DarkModePlatformTheme.fourthBlack,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
                  enableInteractiveSelection: false,
                  onTap: () {
                    _amountController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _amountController.text.length,
                    );
                  },
                  onChanged: (value) async {
                    if (value.length <= 10) {
                      fontSize = 22;
                    } else if (value.length <= 15 && value.length > 10) {
                      fontSize = 20;
                    } else {
                      fontSize = 18;
                    }
                    setState(() {});
                    if (value.isNotEmpty) {
                      int intValue = int.tryParse(value) ?? 1;

                      if (intValue < 0) {
                        final valueData = intValue * -1;
                        _amountController.text = "$valueData";
                        await saveData();
                        value = _amountController.text;
                      }
                      if (intValue == 0) {
                        _amountController.text = "${widget.minAmount}";
                        await saveData();
                        value = _amountController.text;
                      }

                      if ((widget.maxAmount != null &&
                          intValue > widget.maxAmount!)) {
                        _amountController =
                            TextEditingController(text: "${widget.maxAmount}");
                        _amountController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: _amountController.text.length));

                        textData = "${widget.minAmount}";
                        widget.amountFunction(_amountController.text);
                        amount = InputModel(input: _amountController.text);
                      } else if (!isDouble(value)) {
                        _amountController.text = "${widget.minAmount}";
                        _amountController.selection =
                            TextSelection.fromPosition(TextPosition(
                          offset: _amountController.text.length,
                        ));
                      } else {
                        textData = value;
                        widget.amountFunction(value);
                        amount = InputModel(input: _amountController.text);
                      }
                    }
                  },
                  focusNode: _amountFocus,
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  enableSuggestions: false,
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: DarkModePlatformTheme.white,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                    wordSpacing: 0.1,
                  ),
                  showCursor: true,
                  cursorColor: DarkModePlatformTheme.white,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusColor: Colors.transparent,
                    contentPadding: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (isDouble(_amountController.text)) {
                    double? data = double.tryParse(_amountController.text);

                    if ((widget.maxAmount != null &&
                            data! < widget.maxAmount!) ||
                        widget.maxAmount == null) {
                      double? data = double.tryParse(_amountController.text);
                      _amountController.text = "${(data! + 1).toInt()}";
                      setState(() {});
                    } else {
                      _amountController.text = "${widget.maxAmount}";
                    }
                  } else {
                    _amountController.text = "${widget.minAmount}";
                  }

                  textData = _amountController.text;

                  _amountController.selection =
                      TextSelection.fromPosition(TextPosition(
                    offset: _amountController.text.length,
                  ));

                  widget.amountFunction(_amountController.text);
                  amount = InputModel(input: _amountController.text);
                },
                child: Container(
                  width: 45,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DarkModePlatformTheme.white,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/plus.svg",
                    color: DarkModePlatformTheme.secondBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
