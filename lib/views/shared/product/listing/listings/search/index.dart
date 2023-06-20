import 'package:adret/services/product/index.dart';
import 'package:adret/services/products/search.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/product/find.dart';
import 'package:adret/widgets/product/card/productCard/index.dart';
import 'package:adret/widgets/product/card/productCard/loading.dart';
import 'package:adret/widgets/dataFetcher/footer.dart';
import 'package:adret/widgets/dataFetcher/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  late RefreshController _refreshController;
  String searchPhrase = "";
  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);

    final searchProduct =
        Provider.of<SearchProductService>(context, listen: false);
    searchPhrase = searchProduct.searchText;
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final searchProduct =
        Provider.of<SearchProductService>(context, listen: false);
    if (searchProduct.searchText != searchPhrase) {
      _refreshController.loadComplete();
      searchPhrase = searchProduct.searchText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchProduct =
        Provider.of<SearchProductService>(context, listen: true);

    void onRefresh() async {
      try {
        await searchProduct.refreshProducts();
        _refreshController.refreshCompleted();
      } catch (e) {
        _refreshController.refreshFailed();
      }
    }

    void onLoading() async {
      try {
        bool moreData = await searchProduct.loadMoreProducts();
        if (!moreData) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
        }
      } catch (e) {
        _refreshController.loadFailed();
      }
    }

    if (searchProduct.loading) {
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: ((context, index) {
          return const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: ProductLoadingCard(),
          );
        }),
      );
    } else if (searchProduct.searchProducts.isEmpty) {
      return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: SvgPicture.asset(
                  "assets/icons/bold/searchHeader.svg",
                  color: DarkModePlatformTheme.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.searchPrompt,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  color: DarkModePlatformTheme.white,
                  fontWeight: FontWeight.w200,
                  fontSize: 17,
                  height: 1.5,
                  wordSpacing: 1,
                ),
              )
            ],
          ));
    } else {
      return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const DataFetcherHeader(),
        footer: const DataFetcherFooter(),
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: searchProduct.searchProducts.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ProductCard(
                product: searchProduct.searchProducts[index],
                onClick: () {
                  final currentProduct = Provider.of<CurrentProductService>(
                    context,
                    listen: false,
                  );
                  currentProduct.searchUpdateProduct(
                      searchProduct.searchProducts[index], index);
                  Navigator.pushNamed(context, CurrentProductView.routeName);
                },
              ),
            );
          }),
        ),
      );
    }
  }
}
