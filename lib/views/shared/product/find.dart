import 'package:adret/model/cart/index.dart';
import 'package:adret/model/input/index.dart';
import 'package:adret/model/inventoryInput/index.dart';
import 'package:adret/model/inventoryInputTitle/index.dart';
import 'package:adret/model/product/index.dart';
import 'package:adret/model/productVariation/index.dart';
import 'package:adret/model/productView/index.dart';
import 'package:adret/services/cart/index.dart';
import 'package:adret/services/inventory/index.dart';
import 'package:adret/services/inventory/variation.dart';
import 'package:adret/services/product/index.dart';
import 'package:adret/services/user/index.dart';
import 'package:adret/utils/notification/index.dart';
import 'package:adret/utils/role.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/product/update.dart';
import 'package:adret/widgets/product/inventory/output/index.dart';
import 'package:adret/widgets/product/bottom/index.dart';
import 'package:adret/widgets/product/emptyScreen/index.dart';
import 'package:adret/widgets/product/description/output/index.dart';
import 'package:adret/widgets/product/media/output/index.dart';
import 'package:adret/widgets/product/category/output/index.dart';
import 'package:adret/widgets/product/price/output/index.dart';
import 'package:adret/widgets/product/inventory/delegatorHeader/inventoryOutput/index.dart';
import 'package:adret/widgets/product/inventory/card/inventoryCard/index.dart';
import 'package:adret/widgets/header/displayHeader/index.dart';
import 'package:adret/widgets/textIconField/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentProductView extends StatefulWidget {
  static const routeName = '/currentProductView';
  const CurrentProductView({
    super.key,
  });

  @override
  State<CurrentProductView> createState() => _CurrentProductViewState();
}

class _CurrentProductViewState extends State<CurrentProductView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void keyboardDown() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productService =
        Provider.of<CurrentProductService>(context, listen: true);
    final userService = Provider.of<UserService>(context, listen: true);
    ProductModel product = productService.product;

    return Scaffold(
        backgroundColor: DarkModePlatformTheme.secondBlack,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: DisplayHeader(
                      icon: (product.productCode != null)
                          ? isManager(userService.currentUser.userRole ?? "")
                              ? "assets/icons/bold/editBox.svg"
                              : null
                          : null,
                      iconAction: isManager(
                              userService.currentUser.userRole ?? "")
                          ? () {
                              var hiveProduct =
                                  Hive.box<ProductViewModel>('productView');

                              ProductViewModel? hiveData = hiveProduct.get(
                                  "currentProduct",
                                  defaultValue: ProductViewModel());

                              hiveData!.category =
                                  InputModel(input: product.category);

                              hiveData.title = InputModel(input: product.title);
                              hiveData.detail =
                                  InputModel(input: product.detail);

                              hiveData.productCode = product.productCode;

                              List<MediaViewModel> medias = [];
                              if (product.media != null &&
                                  product.media!.isNotEmpty) {
                                for (var media in product.media!) {
                                  medias = [
                                    ...medias,
                                    MediaViewModel(url: media)
                                  ];
                                }
                              }
                              hiveData.media = medias;

                              final variationData =
                                  Provider.of<VariationService>(
                                context,
                                listen: false,
                              );
                              List<InventoryInputModel> inventories = [];
                              if (product.inventory != null &&
                                  product.inventory!.isNotEmpty) {
                                for (var inventory in product.inventory!) {
                                  int? mediaCount;
                                  if (inventory.media != null &&
                                      product.media != null) {
                                    mediaCount = product.media!.indexWhere(
                                        (element) =>
                                            element == inventory.media);
                                  }
                                  List<InventoryInputTitleModel> titles = [];
                                  variationData.resetVariation();
                                  for (var inventoryVariation
                                      in inventory.inventoryVariation!) {
                                    titles = [
                                      ...titles,
                                      InventoryInputTitleModel(
                                        title: inventoryVariation.title!,
                                        value: InputModel(
                                          input: inventoryVariation.data,
                                        ),
                                      )
                                    ];

                                    variationData.addVariation(
                                      ProductVariationModel(
                                        title: inventoryVariation.title!,
                                        selected: true,
                                      ),
                                    );
                                  }
                                  inventories = [
                                    ...inventories,
                                    InventoryInputModel(
                                      id: inventory.id,
                                      amount: InputModel(
                                          input: inventory.available),
                                      initialPrice: InputModel(
                                          input: inventory.initialPrice),
                                      maxSellingPriceEstimation: InputModel(
                                          input: inventory
                                              .maxSellingPriceEstimation),
                                      minSellingPriceEstimation: InputModel(
                                          input: inventory
                                              .minSellingPriceEstimation),
                                      sales: int.tryParse(
                                              inventory.salesAmount ?? "1") ??
                                          1,
                                      media: mediaCount,
                                      title: titles,
                                    )
                                  ];
                                }
                              }

                              hiveData.media = medias;
                              hiveData.inventory = inventories;

                              hiveData.id = product.id;
                              hiveProduct.put("currentProduct", hiveData);
                              Provider.of<InventoryService>(context,
                                      listen: false)
                                  .fetchInventory(null);

                              showCupertinoModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0),
                                  ),
                                ),
                                enableDrag: false,
                                builder: (context) =>
                                    const UpdateProductScreen(),
                              );
                            }
                          : null,
                      size: 24,
                      title: (product.productCode != null)
                          ? '${AppLocalizations.of(context)!.product}-${companyNameRemover(
                              product.productCode,
                            )}'
                          : "",
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: product.id != null
                            ? CustomScrollView(
                                slivers: [
                                  SliverList(
                                    delegate: SliverChildListDelegate(
                                      [
                                        ProductMediaOutput(
                                          media: product.media ?? [],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        if (product.title != null)
                                          TextIconField(
                                            icon: "assets/icons/inventory.svg",
                                            content: product.title!,
                                            ratio1: 1.2,
                                            ratio2: 10.8,
                                            size: 24,
                                          ),
                                        if (product.detail != null &&
                                            product.detail != "")
                                          ProductDescriptionOutput(
                                            detail: product.detail!,
                                          ),
                                        if (product.category != null)
                                          ProductCategoryOutput(
                                            category: product.category!,
                                          ),
                                        SizedBox(
                                          height: (product.inventory != null &&
                                                  product
                                                      .inventory!.isNotEmpty &&
                                                  product.inventory!.length ==
                                                      1)
                                              ? 20
                                              : 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (product.inventory != null &&
                                      product.inventory!.isNotEmpty &&
                                      product.inventory!.length == 1)
                                    SliverList(
                                      delegate: SliverChildListDelegate(
                                        [
                                          ProductPriceOutput(
                                            totalInventory: product
                                                        .inventory![0]
                                                        .available !=
                                                    null
                                                ? product
                                                    .inventory![0].available!
                                                : "0",
                                            sales: product.inventory![0]
                                                        .salesAmount !=
                                                    null
                                                ? product
                                                    .inventory![0].salesAmount!
                                                : "0",
                                            initialPriceValue: product
                                                        .inventory![0]
                                                        .initialPrice !=
                                                    null
                                                ? product
                                                    .inventory![0].initialPrice!
                                                : "0",
                                            maxSellingPriceValue: product
                                                        .inventory![0]
                                                        .maxSellingPriceEstimation !=
                                                    null
                                                ? product.inventory![0]
                                                    .maxSellingPriceEstimation!
                                                : "0",
                                            minSellingPriceValue: product
                                                        .inventory![0]
                                                        .minSellingPriceEstimation !=
                                                    null
                                                ? product.inventory![0]
                                                    .minSellingPriceEstimation!
                                                : "0",
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (product.inventory != null &&
                                      product.inventory!.isNotEmpty &&
                                      product.inventory!.length > 1)
                                    SliverPersistentHeader(
                                      pinned: true,
                                      floating: true,
                                      delegate: InventoryHeaderDelegate(
                                        toolBarHeight: 40,
                                        closedHeight: 0,
                                        openHeight: 0,
                                      ),
                                    ),
                                  if (product.inventory != null &&
                                      product.inventory!.isNotEmpty &&
                                      product.inventory!.length > 1)
                                    SliverList(
                                      delegate: SliverChildListDelegate(
                                        [
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Divider(
                                            height: 2,
                                            color: DarkModePlatformTheme.white,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (product.inventory != null &&
                                      product.inventory!.isNotEmpty &&
                                      product.inventory!.length > 1)
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        childCount: product.inventory!.length,
                                        (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Dismissible(
                                              onDismissed: (value) {},
                                              confirmDismiss: (value) async {
                                                final cartService =
                                                    Provider.of<CartService>(
                                                        context,
                                                        listen: false);
                                                if (value ==
                                                    DismissDirection
                                                        .startToEnd) {
                                                  int available = int.tryParse(
                                                          product
                                                              .inventory![index]
                                                              .available!) ??
                                                      0;
                                                  int sale = int.tryParse(
                                                          product
                                                              .inventory![index]
                                                              .salesAmount!) ??
                                                      0;
                                                  int left = available - sale;

                                                  if (left > 0) {
                                                    cartService.addCart(
                                                      CartModel(
                                                        amount: InputModel(
                                                            input: 1),
                                                        inventory: product
                                                            .inventory![index],
                                                        productCode: product
                                                            .productCode!,
                                                        title: product.title!,
                                                        sellingPrice: InputModel(
                                                            input: double
                                                                .tryParse(product
                                                                    .inventory![
                                                                        index]
                                                                    .maxSellingPriceEstimation!)),
                                                        totalPrice: double
                                                            .tryParse(product
                                                                .inventory![
                                                                    index]
                                                                .maxSellingPriceEstimation!)!,
                                                        media: product.inventory !=
                                                                    null &&
                                                                product
                                                                        .inventory![
                                                                            index]
                                                                        .media !=
                                                                    null
                                                            ? product
                                                                .inventory![
                                                                    index]
                                                                .media
                                                            : null,
                                                        productIndex:
                                                            productService
                                                                .index,
                                                        inventoryIndex: index,
                                                      ),
                                                    );
                                                    successNotification(
                                                        context: context,
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .cartAdded,
                                                        bottom: 0);
                                                  } else {
                                                    errorNotification(
                                                      context: context,
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .outOfStock,
                                                      bottom: 0,
                                                    );
                                                  }
                                                }
                                                return false;
                                              },
                                              direction:
                                                  DismissDirection.startToEnd,
                                              background: Container(
                                                decoration: BoxDecoration(
                                                  color: DarkModePlatformTheme
                                                      .primaryLight3,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: SizedBox(
                                                    width: 40,
                                                    child: SvgPicture.asset(
                                                      "assets/icons/bold/addCart.svg",
                                                      width: 40,
                                                      height: 40,
                                                      color:
                                                          DarkModePlatformTheme
                                                              .primaryDark2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              key: UniqueKey(),
                                              child: GestureDetector(
                                                onTap: () {
                                                  showCupertinoModalBottomSheet(
                                                    context: context,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            25.0),
                                                      ),
                                                    ),
                                                    enableDrag: true,
                                                    builder: (context) =>
                                                        InventoryScreen(
                                                      product: product,
                                                      inventory: product
                                                          .inventory![index],
                                                      productIndex:
                                                          productService.index,
                                                      inventoryIndex: index,
                                                    ),
                                                  );
                                                },
                                                child: InventoryCard(
                                                  inventory:
                                                      product.inventory![index],
                                                  index: index,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  SliverList(
                                    delegate: SliverChildListDelegate(
                                      [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .padding
                                                  .bottom +
                                              50,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const EmptyProductView()),
                  )),
                ],
              ),
            ),
            if (product.inventory != null &&
                product.inventory!.isNotEmpty &&
                product.inventory!.length == 1)
              ProductBottom(
                product: product,
                index: productService.index,
              ),
          ],
        ));
  }
}
