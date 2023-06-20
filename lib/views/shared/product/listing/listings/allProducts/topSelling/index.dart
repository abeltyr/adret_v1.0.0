import 'package:adret/model/product/index.dart';
import 'package:adret/services/product/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/product/find.dart';
import 'package:adret/widgets/product/card/verticalLoadingProduct/index.dart';
import 'package:adret/widgets/product/card/verticalProduct/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopSelling extends StatelessWidget {
  final List<ProductModel> product;
  final bool loading;
  const TopSelling({super.key, required this.product, required this.loading});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          AppLocalizations.of(context)!.topSelling,
          style: const TextStyle(
            fontFamily: 'Nunito',
            color: DarkModePlatformTheme.white,
            fontWeight: FontWeight.w100,
            fontSize: 22.5,
            wordSpacing: 1,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        if (loading && product.isEmpty)
          SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            height: 155,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return const VerticalLoadingProduct();
              },
            ),
          )
        else if (product.isNotEmpty)
          SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            height: 155,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: product.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    final currentProduct = Provider.of<CurrentProductService>(
                        context,
                        listen: false);
                    currentProduct.updateProduct(product[index], index);
                    // CupertinoScaffold.showCupertinoModalBottomSheet(
                    //   context: context,
                    //   backgroundColor: DarkModePlatformTheme.primaryDark,
                    //   builder: (context) => const CurrentProductView(),
                    // );
                    Navigator.pushNamed(context, CurrentProductView.routeName);
                  },
                  child: VerticalProduct(product: product[index], index: index),
                );
              },
            ),
          ),
      ],
    );
  }
}
