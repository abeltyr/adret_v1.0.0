import 'package:adret/services/inventory/index.dart';
import 'package:adret/services/inventory/variation.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/inventory/inputScreen/index.dart';
import 'package:adret/widgets/product/inventory/variationScreen/index.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddInventoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  double toolBarHeight;
  double closedHeight;
  double openHeight;
  AddInventoryHeaderDelegate({
    this.toolBarHeight = 0,
    this.closedHeight = 0,
    this.openHeight = 0,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final variationService =
        Provider.of<VariationService>(context, listen: true);
    final inventoryService =
        Provider.of<InventoryService>(context, listen: true);
    return Container(
      height: 50,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.productDetail,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: 'Nunito',
              color: DarkModePlatformTheme.grey5,
              fontWeight: FontWeight.w400,
              fontSize: 22,
              wordSpacing: 0.1,
              letterSpacing: 0.5,
            ),
          ),
          Row(
            children: [
              SizedBox(
                height: 35,
                width: 35,
                child: MainButton(
                  textFontSize: 15,
                  borderRadiusData: 5,
                  onClick: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    showBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      enableDrag: false,
                      builder: (context) => const VariationView(),
                    );
                  },
                  icon: "assets/icons/stack.svg",
                ),
              ),
              if (variationService.selectedVariations.isNotEmpty)
                const SizedBox(
                  width: 12,
                ),
              if (variationService.selectedVariations.isNotEmpty)
                SizedBox(
                  height: 35,
                  width: 35,
                  child: MainButton(
                    textFontSize: 15,
                    borderRadiusData: 5,
                    onClick: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      int indexData = await inventoryService
                          .addInventory(variationService.selectedVariations);

                      // ignore: use_build_context_synchronously
                      showBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        enableDrag: false,
                        builder: (context) => InventorySetupScreen(
                          index: indexData,
                          newInventory: true,
                        ),
                      );
                    },
                    icon: "assets/icons/bold/add.svg",
                  ),
                ),
            ],
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
