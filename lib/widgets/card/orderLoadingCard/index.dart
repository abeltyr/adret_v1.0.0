import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/card/iconText/loading.dart';
import 'package:adret/widgets/card/orderLoadingCard/order_top.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderLoadingCard extends StatelessWidget {
  const OrderLoadingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        border: Border.all(
          color: DarkModePlatformTheme.fourthBlack,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: DarkModePlatformTheme.darkWhite1,
            highlightColor: DarkModePlatformTheme.darkWhite,
            child: const OrderTopLoading(),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: DarkModePlatformTheme.fourthBlack.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: DarkModePlatformTheme.darkWhite1,
                  highlightColor: DarkModePlatformTheme.darkWhite,
                  child: const IconTextCardLoading(),
                ),
                Shimmer.fromColors(
                  baseColor: DarkModePlatformTheme.darkWhite1,
                  highlightColor: DarkModePlatformTheme.darkWhite,
                  child: const IconTextCardLoading(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
