import 'package:adret/model/product/index.dart';
import 'package:adret/services/product/index.dart';
import 'package:adret/services/products/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/product/create.dart';
import 'package:adret/views/shared/product/find.dart';
import 'package:adret/widgets/empty/index.dart';
import 'package:adret/widgets/product/card/productCard/index.dart';
import 'package:adret/widgets/product/card/productCard/loading.dart';
import 'package:adret/widgets/dataFetcher/footer.dart';
import 'package:adret/widgets/dataFetcher/header.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductListing extends StatefulWidget {
  final String role;
  const ProductListing({
    super.key,
    required this.role,
  });

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  dynamic user;
  int count = 0;
  bool error = false;
  List<ProductModel> products = [];
  bool errorLoading = false;

  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);

    fetchData();
    super.initState();
  }

  fetchData() async {
    final product = Provider.of<ProductService>(context, listen: false);
    try {
      if (errorLoading && mounted) {
        setState(() {
          errorLoading = false;
        });
      }
      await product.refreshProducts();
    } catch (e) {
      if (mounted) {
        setState(() {
          errorLoading = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductService>(context, listen: true);
    count = product.products.length;

    void onRefresh() async {
      try {
        await product.refreshProducts();
        _refreshController.refreshCompleted();
      } catch (e) {
        _refreshController.refreshFailed();
      }
    }

    void onLoading() async {
      try {
        bool moreData = await product.loadMoreProducts();
        if (!moreData) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
        }
      } catch (e) {
        _refreshController.loadFailed();
      }
    }

    List<ProductModel> products = product.products;
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const DataFetcherHeader(),
      footer: const DataFetcherFooter(),
      controller: _refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: CustomScrollView(
        slivers: [
          if (product.products.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: count,
                (context, index) {
                  ProductModel productData = products[index];
                  if (product.products.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ProductCard(
                        product: productData,
                        index: index,
                        onClick: () {
                          final currentProduct =
                              Provider.of<CurrentProductService>(
                            context,
                            listen: false,
                          );
                          currentProduct.updateProduct(productData, index);
                          Navigator.pushNamed(
                              context, CurrentProductView.routeName);
                        },
                      ),
                    );
                  } else {
                    return const Stack();
                  }
                },
              ),
            ),
          if (product.loading && product.products.isEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 20,
                (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: ProductLoadingCard(),
                  );
                },
              ),
            ),
          if (!product.loading && product.products.isEmpty && !errorLoading)
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(
                    height: 100,
                  ),
                  EmptyState(
                    action: () {
                      CupertinoScaffold.showCupertinoModalBottomSheet(
                        context: context,
                        enableDrag: false,
                        backgroundColor: DarkModePlatformTheme.secondBlack,
                        builder: (context) => const CreateProduct(),
                      );
                    },
                    actionIcon: widget.role == "Manager"
                        ? "assets/icons/bold/add.svg"
                        : null,
                    actionText: widget.role == "Manager"
                        ? AppLocalizations.of(context)!.add
                        : null,
                    subText:
                        widget.role == AppLocalizations.of(context)!.manager
                            ? AppLocalizations.of(context)!.addProductPrompt
                            : AppLocalizations.of(context)!.addProductNotice,
                    topText: AppLocalizations.of(context)!.noProducts,
                  )
                ],
              ),
            ),
          if (!product.loading && product.products.isEmpty && errorLoading)
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(
                    height: 100,
                  ),
                  EmptyState(
                    action: () {
                      fetchData();
                    },
                    emptyIcon: "assets/icons/warning.svg",
                    height: 150,
                    actionIcon: "assets/icons/bold/reload.svg",
                    actionText: AppLocalizations.of(context)!.retry,
                    subText: AppLocalizations.of(context)!.productsFetchError,
                    topText:
                        AppLocalizations.of(context)!.productsFetchErrorTitle,
                  )
                ],
              ),
            ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
