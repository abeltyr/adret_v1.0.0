import 'package:adret/model/order/index.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/card/iconText/index.dart';
import 'package:adret/widgets/card/orderCard/order_top.dart';
import 'package:adret/widgets/card/orderCard/order_top_product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double totalProfit = double.tryParse(order.totalProfit ?? "0") ?? 0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        border: Border.all(
          color: DarkModePlatformTheme.grey4,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          if (order.sales != null && order.sales!.length > 1)
            OrderTopProduct(
              orderNumber: order.orderNumber ?? "",
              productCount: order.sales?.length.toString() ?? "0",
              sellerName: order.seller!.fullName ?? "",
            )
          else
            OrderTop(
              orderNumber: order.orderNumber ?? "",
              sellerName: order.seller!.fullName ?? "",
            ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: DarkModePlatformTheme.thirdBlack.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextCard(
                  title: AppLocalizations.of(context)!.earning,
                  subTitle: priceShow(order.totalPrice.toString()),
                  icon: "assets/icons/bold/moneys.svg",
                  titleColor: totalProfit > 0
                      ? DarkModePlatformTheme.positiveLight2
                      : DarkModePlatformTheme.negativeLight2,
                  subTitleColor: totalProfit > 0
                      ? DarkModePlatformTheme.positiveLight3
                      : DarkModePlatformTheme.negativeLight3,
                  iconColor: totalProfit > 0
                      ? DarkModePlatformTheme.positiveLight3
                      : DarkModePlatformTheme.negativeLight3,
                ),
                IconTextCard(
                  title: AppLocalizations.of(context)!.date,
                  subTitle: DateFormat("yMMMd").format(order.date != null
                      ? DateTime.parse(
                          order.date ?? "",
                        )
                      : DateTime.now()),
                  icon: "assets/icons/bold/calendar.svg",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
