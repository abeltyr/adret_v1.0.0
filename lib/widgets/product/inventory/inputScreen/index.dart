import 'package:adret/model/input/index.dart';
import 'package:adret/model/inventoryInput/index.dart';
import 'package:adret/model/inventoryInputTitle/index.dart';
import 'package:adret/services/inventory/index.dart';
import 'package:adret/services/product/actions/media.dart';
import 'package:adret/utils/notification/index.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/price/input/index.dart';
import 'package:adret/widgets/product/inventory/inputScreen/imageSelection/index.dart';
import 'package:adret/widgets/product/inventory/card/inventoryInputCard/image/index.dart';
import 'package:adret/widgets/header/textHeader/index.dart';
import 'package:adret/widgets/product/amount/index.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InventorySetupScreen extends StatefulWidget {
  final int index;
  final bool newInventory;
  const InventorySetupScreen({
    super.key,
    required this.index,
    required this.newInventory,
  });

  @override
  State<InventorySetupScreen> createState() => _InventorySetupScreenState();
}

class _InventorySetupScreenState extends State<InventorySetupScreen> {
  String title = "";
  String value = "";
  List<InventoryInputTitleModel> titles = [];
  late InventoryInputModel initialData;
  late InputModel amount;
  late int sale;
  late InputModel initialPrice;
  late InputModel maxSellingPriceEstimation;
  late InputModel minSellingPriceEstimation;
  int? inventoryMedia;

  @override
  void initState() {
    super.initState();
    final inventoryService =
        Provider.of<InventoryService>(context, listen: false);

    amount = InputModel(
        input: inventoryService.inventories[widget.index].amount.input);
    initialPrice = InputModel(
        input: inventoryService.inventories[widget.index].initialPrice.input);
    minSellingPriceEstimation = InputModel(
        input: inventoryService
            .inventories[widget.index].minSellingPriceEstimation.input);
    maxSellingPriceEstimation = InputModel(
        input: inventoryService
            .inventories[widget.index].maxSellingPriceEstimation.input);

    inventoryMedia = inventoryService.inventories[widget.index].media;

    sale = inventoryService.inventories[widget.index].sales == 0
        ? 1
        : inventoryService.inventories[widget.index].sales ?? 1;
    if (inventoryService.inventories[widget.index].title != null) {
      titles = inventoryService.inventories[widget.index].title!;
    }

    initialData = inventoryService.inventories[widget.index];
    getTitle();
  }

  getTitle() {
    if (mounted) {
      var titleData = "";
      var valueData = "";
      for (var data in titles) {
        titleData =
            "$titleData${titleData.isEmpty ? '' : ' - '}${capitalize(data.title)}";
        valueData =
            "$valueData${valueData.isNotEmpty && data.value.input.isNotEmpty ? ' - ' : ''}${(data.value.input)}";
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
    final inventoryService =
        Provider.of<InventoryService>(context, listen: false);
    return Scaffold(
      backgroundColor: DarkModePlatformTheme.secondBlack,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: (() {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        }),
        child: Column(
          children: [
            TextHeader(
              closeText: AppLocalizations.of(context)!.cancel,
              actionText: !widget.newInventory
                  ? AppLocalizations.of(context)!.update
                  : AppLocalizations.of(context)!.add,
              actionFunction: () async {
                InventoryInputModel newInventory = InventoryInputModel(
                  amount: amount,
                  initialPrice: initialPrice,
                  maxSellingPriceEstimation: maxSellingPriceEstimation,
                  minSellingPriceEstimation: minSellingPriceEstimation,
                  title: titles,
                  sales: sale,
                  media: inventoryMedia,
                  id: inventoryService.inventories[widget.index].id,
                );
                bool validate = await inventoryService.validateInventory(
                  newInventory,
                  (text) {
                    errorNotification(context: context, text: text, bottom: 0);
                  },
                  context,
                );

                if (validate) {
                  inventoryService.updateInventory(
                      newInventory, widget.index, null);
                  inventoryService.saveInventory();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
              closeFunction: () {
                if (!widget.newInventory &&
                    initialData != inventoryService.inventories[widget.index]) {
                  inventoryService.updateInventory(
                      initialData, widget.index, null);
                } else if (!widget.newInventory &&
                    initialData == inventoryService.inventories[widget.index]) {
                } else if (widget.newInventory) {
                  inventoryService.removeInventoryState(widget.index);
                }
              },
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(children: [
                            GestureDetector(
                              onTap: (() {
                                var media = fetchProductImages();
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15.0),
                                    ),
                                  ),
                                  context: context,
                                  backgroundColor: DarkModePlatformTheme.black,
                                  builder: (context) => InventoryImageSelection(
                                    selectedIndex: inventoryMedia,
                                    images: media ?? [],
                                    setFunction: (p0) {
                                      setState(() {
                                        inventoryMedia = p0;
                                      });
                                    },
                                    removeFunction: () {
                                      setState(() {
                                        inventoryMedia = null;
                                      });
                                    },
                                  ),
                                );
                              }),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: InventoryInputCardImage(
                                  image: inventoryMedia,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: DarkModePlatformTheme.white
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.w200,
                                    fontSize: 20,
                                    wordSpacing: 1,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7.5,
                                ),
                                Text(
                                  overflow: TextOverflow.clip,
                                  value,
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: DarkModePlatformTheme.white
                                        .withOpacity(0.75),
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
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: titles.length,
                      (context, index) {
                        return Container(
                          height: 85,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                capitalize(titles[index].title),
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: DarkModePlatformTheme.white
                                      .withOpacity(0.75),
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20,
                                  wordSpacing: 1,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: Input(
                                size: 20,
                                textInputAction: TextInputAction.next,
                                label:
                                    "${capitalize(titles[index].title)} ${AppLocalizations.of(context)!.value}",
                                paddingData: 0,
                                divider: true,
                                onChanged: (p0) {
                                  titles[index].value = InputModel(input: p0);
                                  getTitle();
                                },
                                valueSetter: () {
                                  return titles[index].value;
                                },
                              ),
                            )
                          ]),
                        );
                      },
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          margin: const EdgeInsets.all(
                            16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.available,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  color: DarkModePlatformTheme.white,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20,
                                  wordSpacing: 0.1,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              ProductAmountInput(
                                amountFunction: (value) {
                                  amount.input = value;
                                },
                                amount: amount,
                                minAmount: sale,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: ProductPriceInput(
                            backgroundColor: DarkModePlatformTheme.fourthBlack,
                            initialPriceFunction: (value) {
                              initialPrice.input = value;
                            },
                            sellingPriceFunction:
                                (minSellingPrice, maxSellingPrice) {
                              maxSellingPriceEstimation = maxSellingPrice;
                              minSellingPriceEstimation = minSellingPrice;
                            },
                            initialPriceValue: initialPrice,
                            maxSellingPriceValue: maxSellingPriceEstimation,
                            minSellingPriceValue: minSellingPriceEstimation,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ), // InventoryListing(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // child: Column(
      //   children: [

      //   ],
      // ),
    );
  }
}
