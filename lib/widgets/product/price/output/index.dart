import 'package:adret/services/user/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/card/iconColumnText/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductPriceOutput extends StatelessWidget {
  final String initialPriceValue;
  final String minSellingPriceValue;
  final String maxSellingPriceValue;
  final String totalInventory;
  final String sales;
  const ProductPriceOutput({
    super.key,
    required this.initialPriceValue,
    required this.minSellingPriceValue,
    required this.maxSellingPriceValue,
    required this.totalInventory,
    required this.sales,
  });

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: false);
    double total = double.tryParse(totalInventory) ?? 0;
    double salesData = double.tryParse(sales) ?? 0;
    int remaining = (total - salesData).toInt();

    return LayoutBuilder(builder: (context, snapshot) {
      double width = (MediaQuery.of(context).size.width - 30) / 2;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.productDetail,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 18,
              fontWeight: FontWeight.w200,
              color: DarkModePlatformTheme.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              IconColumnText(
                icon: "assets/icons/bold/box.svg",
                subText: "$remaining",
                ration1: 2.5,
                ration2: 7.5,
                title: AppLocalizations.of(context)!.remaining,
                color: DarkModePlatformTheme.fourthBlack,
                iconColor: DarkModePlatformTheme.white,
                paddingSize: 2.5,
                width: width,
                titleFontSize: 16,
                subsTextFontSize: 18,
                subTextColor: DarkModePlatformTheme.white,
                topTextColor: DarkModePlatformTheme.grey4,
                subtextFontWeight: FontWeight.w200,
                titleFontWeight: FontWeight.w500,
              ),
              if (userService.currentUser.userRole == "Manager")
                IconColumnText(
                  icon: "assets/icons/bold/moneySend.svg",
                  subText: initialPriceValue,
                  title: AppLocalizations.of(context)!.buyingPrice,
                  paddingSize: 2.5,
                  ration1: 2.5,
                  ration2: 7.5,
                  color: DarkModePlatformTheme.fourthBlack,
                  iconColor: DarkModePlatformTheme.white,
                  width: width,
                  titleFontSize: 16,
                  subsTextFontSize: 18,
                  subTextColor: DarkModePlatformTheme.white,
                  topTextColor: DarkModePlatformTheme.grey4,
                  subtextFontWeight: FontWeight.w200,
                  titleFontWeight: FontWeight.w500,
                ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          if (maxSellingPriceValue != minSellingPriceValue)
            Text(
              AppLocalizations.of(context)!.sellingPrice,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: DarkModePlatformTheme.white,
              ),
            ),
          if (maxSellingPriceValue != minSellingPriceValue)
            const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (maxSellingPriceValue != minSellingPriceValue)
                IconColumnText(
                  icon: "assets/icons/bold/moneyReceive.svg",
                  subText: minSellingPriceValue,
                  title: AppLocalizations.of(context)!.min,
                  paddingSize: 2.5,
                  ration1: 2.5,
                  ration2: 7.5,
                  color: DarkModePlatformTheme.thirdBlack,
                  iconColor: DarkModePlatformTheme.positiveLight3,
                  width: width,
                  titleFontSize: 16,
                  subsTextFontSize: 18,
                  subTextColor: DarkModePlatformTheme.positiveLight3,
                  topTextColor: DarkModePlatformTheme.grey4,
                  subtextFontWeight: FontWeight.w200,
                  titleFontWeight: FontWeight.w500,
                ),
              IconColumnText(
                icon: "assets/icons/bold/moneyReceive.svg",
                subText: maxSellingPriceValue,
                title: maxSellingPriceValue == minSellingPriceValue
                    ? AppLocalizations.of(context)!.sellingPrice
                    : AppLocalizations.of(context)!.max,
                color: DarkModePlatformTheme.thirdBlack,
                iconColor: DarkModePlatformTheme.positiveLight3,
                ration1: 2.5,
                ration2: 7.5,
                paddingSize: 5,
                width: width,
                titleFontSize: 16,
                subsTextFontSize: 18,
                subTextColor: DarkModePlatformTheme.positiveLight3,
                topTextColor: DarkModePlatformTheme.grey4,
                subtextFontWeight: FontWeight.w200,
                titleFontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      );
    });
  }
}
