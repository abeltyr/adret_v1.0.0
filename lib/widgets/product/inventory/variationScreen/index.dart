import 'package:adret/model/input/index.dart';
import 'package:adret/model/productVariation/index.dart';
import 'package:adret/services/inventory/variation.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:adret/widgets/header/textHeader/index.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VariationView extends StatefulWidget {
  const VariationView({super.key});

  @override
  State<VariationView> createState() => _VariationViewState();
}

class _VariationViewState extends State<VariationView> {
  late TextEditingController _productVariationController;
  late InputModel inputData;
  bool showAdd = false;

  @override
  void initState() {
    super.initState();
    inputData = InputModel();
    _productVariationController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    _productVariationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final variationData = Provider.of<VariationService>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: DarkModePlatformTheme.secondBlack,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextHeader(
                centerText: AppLocalizations.of(context)!.variations,
                actionFunction: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  Navigator.pop(context);
                },
                showCloseText: false,
                actionText: AppLocalizations.of(context)!.done,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: LayoutBuilder(builder: (context, snapshot) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Input(
                          icon: "assets/icons/stack.svg",
                          controller: _productVariationController,
                          label: AppLocalizations.of(context)!.variation,
                          onDone: (data) {
                            var textData =
                                _productVariationController.text.trim();
                            if (textData.isEmpty) {
                              inputData.errorStatus = true;
                              inputData.errorMessage =
                                  AppLocalizations.of(context)!.validTextPrompt;
                              setState(() {});
                              return;
                            }

                            variationData.addVariation(
                              ProductVariationModel(
                                title: capitalize(
                                    _productVariationController.text),
                                selected: true,
                              ),
                            );

                            _productVariationController.text = "";
                          },
                          onChanged: (value) {
                            if (inputData.errorStatus &&
                                value.trim().isNotEmpty) {
                              inputData.errorStatus = false;
                              inputData.errorMessage = "";
                              setState(() {});
                            }
                            if (value.isNotEmpty) {
                              setState(() {
                                showAdd = true;
                              });
                            } else {
                              setState(() {
                                showAdd = false;
                              });
                            }
                          },
                          valueSetter: () {
                            return inputData;
                          },
                          divider: true,
                          size: 22,
                          ratio1: 1.2,
                          ratio2: 10.8,
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        reverseDuration: const Duration(milliseconds: 300),
                        child: showAdd
                            ? SizedBox(
                                width: 40,
                                height: 40,
                                child: MainButton(
                                  borderRadiusData: 5,
                                  textFontSize: 34,
                                  icon: "assets/icons/plus.svg",
                                  color: DarkModePlatformTheme.primaryLight1,
                                  textColor: DarkModePlatformTheme.primaryDark2,
                                  onClick: () {
                                    var textData =
                                        _productVariationController.text.trim();
                                    if (textData.isEmpty) {
                                      inputData.errorStatus = true;
                                      inputData.errorMessage =
                                          "Please proved a valid text";
                                      setState(() {});
                                      return;
                                    }

                                    variationData.addVariation(
                                      ProductVariationModel(
                                        title: textData,
                                        selected: true,
                                      ),
                                    );

                                    _productVariationController.text = "";
                                  },
                                ),
                              )
                            : const Stack(),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: variationData.variations.variations.length,
                    itemBuilder: ((context, index) {
                      List<ProductVariationModel> variation =
                          variationData.variations.variations;
                      final title = variation[index].title;
                      final selected = variation[index].selected;

                      return Container(
                        margin: EdgeInsets.only(
                            bottom: index + 1 == variation.length ? 80 : 10),
                        child: Dismissible(
                          onDismissed: (value) {},
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              variationData.removeVariation(index);
                              return false;
                            }
                            return false;
                          },
                          direction: DismissDirection.endToStart,
                          background: Container(
                            decoration: BoxDecoration(
                              color: DarkModePlatformTheme.negativeLight3,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(
                                right: 20,
                              ),
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 30,
                                child: SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                  width: 27.5,
                                  height: 27.5,
                                  color: DarkModePlatformTheme.negativeDark1,
                                ),
                              ),
                            ),
                          ),
                          key: UniqueKey(),
                          child: AnimatedContainer(
                            duration: const Duration(microseconds: 200),
                            height: 45,
                            child: MainButton(
                              onClick: () {
                                if (variationData.selectedVariations.length <
                                        3 ||
                                    selected) {
                                  variationData.variationSelection(
                                      index, !selected);
                                }
                              },
                              borderRadiusData: 5,
                              color: selected
                                  ? DarkModePlatformTheme.grey5
                                  : DarkModePlatformTheme.grey1,
                              textColor: selected
                                  ? DarkModePlatformTheme.secondBlack
                                  : DarkModePlatformTheme.white
                                      .withOpacity(0.5),
                              title: (title),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
          Positioned(
            bottom: 15,
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: DarkModePlatformTheme.grey4,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/stack.svg",
                        width: 20,
                        height: 20,
                        color: DarkModePlatformTheme.grey1,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        AppLocalizations.of(context)!.variations,
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: DarkModePlatformTheme.grey1,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${variationData.selectedVariations.length}/3",
                    style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: DarkModePlatformTheme.grey1),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
