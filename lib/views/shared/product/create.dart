import 'package:adret/model/input/index.dart';
import 'package:adret/model/inventoryInput/index.dart';
import 'package:adret/model/product/index.dart';
import 'package:adret/model/productView/index.dart';
import 'package:adret/services/inventory/index.dart';
import 'package:adret/services/inventory/variation.dart';
import 'package:adret/services/product/actions/text.dart';
import 'package:adret/services/products/actions/create_product.dart';
import 'package:adret/services/products/actions/validate.dart';
import 'package:adret/services/products/index.dart';
import 'package:adret/utils/error/image.dart';
import 'package:adret/utils/notification/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/category/input/index.dart';
import 'package:adret/widgets/product/description/input/description.dart';
import 'package:adret/widgets/product/inventory/delegatorHeader/inventoryInput/index.dart';
import 'package:adret/widgets/product/inventory/detail/index.dart';
import 'package:adret/widgets/product/inventory/inventoryListing/index.dart';
import 'package:adret/widgets/header/textHeader/index.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:adret/widgets/product/media/input/index.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../loading/index.dart';

class CreateProduct extends StatefulWidget {
  static const routeName = '/createProduct';
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  bool loading = false;
  InputModel title = InputModel();

  late TextEditingController _titleController;
  late String productCode;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    var hiveProduct = Hive.box<ProductViewModel>('productView');
    ProductViewModel? hiveData =
        hiveProduct.get("currentProduct", defaultValue: ProductViewModel());

    _titleController = TextEditingController(
        text: hiveData!.title != null && hiveData.title!.input != null
            ? hiveData.title!.input.toString()
            : "");
    title = hiveData.title ?? InputModel();
    if (title.input != null) {
      _titleController.selection =
          TextSelection.fromPosition(TextPosition(offset: title.input.length));
    }
    final inventoryService =
        Provider.of<InventoryService>(context, listen: false);

    final variationData = Provider.of<VariationService>(context, listen: false);
    inventoryService.fetchInventory(variationData.selectedVariations);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  void keyboardDown() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    var hiveProduct = Hive.box<ProductViewModel>('productView');
    final product = Provider.of<ProductService>(context, listen: false);
    final inventoryService =
        Provider.of<InventoryService>(context, listen: false);

    final variationData = Provider.of<VariationService>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              keyboardDown();
            },
            child: Container(
              color: DarkModePlatformTheme.secondBlack,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  TextHeader(
                    actionText: AppLocalizations.of(context)!.save,
                    closeText: AppLocalizations.of(context)!.close,
                    centerText: AppLocalizations.of(context)!.addProduct,
                    cover: '${Localizations.localeOf(context)}' == "en",
                    closeFunction: () {
                      if (title.input != null) {
                        updateTitle(data: title.input);
                      }
                    },
                    actionFunction: () async {
                      ProductViewModel hiveData =
                          await inventoryService.fetchProduct(null);
                      // ignore: use_build_context_synchronously
                      bool validation = await validateProductsFunction(
                        hiveData: hiveData,
                        context: context,
                        title: title,
                      );

                      if (!validation) return;
                      try {
                        loading = true;
                        setState(() {});
                        ProductModel response =
                            await createProductFunction(hiveData);
                        hiveProduct.put("currentProduct", ProductViewModel());
                        product.addProduct(response);
                        variationData.resetVariation();
                        inventoryService.cleanInventory();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      } catch (e) {
                        String errorMessage =
                            // ignore: use_build_context_synchronously
                            AppLocalizations.of(context)!.errorNotification;
                        if (e.toString().contains("to large")) {
                          errorMessage = e.toString().replaceRange(0, 10, "");
                        }
                        if (ImageSizeException == e) {
                          ImageSizeException error = e as ImageSizeException;
                          errorMessage = error.msg;
                        }
                        // ignore: use_build_context_synchronously
                        errorNotification(
                            context: context, text: errorMessage, bottom: 0);
                      }
                      loading = false;
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ValueListenableBuilder<Box>(
                        valueListenable:
                            Hive.box<ProductViewModel>('productView')
                                .listenable(),
                        builder: (context, box, widget) {
                          ProductViewModel data = box.get(
                            'currentProduct',
                            defaultValue: ProductViewModel(
                              inventory: [
                                InventoryInputModel(
                                  amount: InputModel(input: 1),
                                  sales: 0,
                                  initialPrice: InputModel(),
                                  minSellingPriceEstimation: InputModel(),
                                  maxSellingPriceEstimation: InputModel(),
                                  title: [],
                                ),
                              ],
                            ),
                          );

                          return CustomScrollView(
                            slivers: [
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    ProductMediaInput(
                                      media: data.media ?? [],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Input(
                                      valueSetter: () {
                                        return title;
                                      },
                                      onChanged: (value) {
                                        title.input = value;
                                      },
                                      icon: "assets/icons/inventory.svg",
                                      controller: _titleController,
                                      label: AppLocalizations.of(context)!
                                          .productTitle,
                                      ratio1: 1.2,
                                      ratio2: 10.8,
                                    ),
                                    ProductDescriptionInput(
                                      detail: data.detail ?? InputModel(),
                                      updateFunction: (value) {
                                        updateDetail(data: value);
                                      },
                                    ),
                                    ProductCategoryInput(
                                      category: data.category ?? InputModel(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              SliverPersistentHeader(
                                pinned: true,
                                floating: true,
                                delegate: AddInventoryHeaderDelegate(
                                  toolBarHeight: 50,
                                  closedHeight: 0,
                                  openHeight: 0,
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    const Divider(
                                      height: 2,
                                      color: DarkModePlatformTheme.grey5,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                              if (variationData.selectedVariations.isEmpty)
                                SliverList(
                                  delegate: SliverChildListDelegate(
                                    [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const InventoryDetail(
                                        index: 0,
                                      ),
                                    ],
                                  ),
                                )
                              else
                                InventoryListing(
                                  inventories: data.inventory ?? [],
                                ),
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (loading)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: LoadingScreen(
                color: DarkModePlatformTheme.grey5.withOpacity(0.5),
                duration: const Duration(milliseconds: 500),
                minHeight: 300,
                maxHeight: 450,
              ),
            ),
        ],
      ),
    );
  }
}
