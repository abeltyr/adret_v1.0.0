import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InventoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  double toolBarHeight;
  double closedHeight;
  double openHeight;
  InventoryHeaderDelegate({
    this.toolBarHeight = 0,
    this.closedHeight = 0,
    this.openHeight = 0,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 40,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: (MediaQuery.of(context).size.width - 30) * 0.65 / 10,
            height: (MediaQuery.of(context).size.width - 30) * 0.65 / 10,
            child: SvgPicture.asset(
              "assets/icons/stack.svg",
              color: DarkModePlatformTheme.darkWhite,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            AppLocalizations.of(context)!.inventories,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: 'Nunito',
              color: DarkModePlatformTheme.darkWhite,
              fontWeight: FontWeight.w400,
              fontSize: 24,
              wordSpacing: 0.1,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => toolBarHeight + openHeight;

  @override
  double get minExtent => toolBarHeight + closedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
