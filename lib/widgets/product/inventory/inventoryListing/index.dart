import 'package:adret/model/inventoryInput/index.dart';
import 'package:adret/services/inventory/index.dart';
import 'package:adret/services/inventory/variation.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/inventory/empty/index.dart';
import 'package:adret/widgets/product/inventory/card/inventoryInputCard/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../inputScreen/index.dart';

class InventoryListing extends StatelessWidget {
  final List<InventoryInputModel> inventories;
  const InventoryListing({
    super.key,
    required this.inventories,
  });

  @override
  Widget build(BuildContext context) {
    final inventoryService =
        Provider.of<InventoryService>(context, listen: true);

    if (inventories.isEmpty ||
        (inventories.length == 1 &&
            inventories[0].initialPrice.input == null)) {
      return SliverList(
          delegate: SliverChildListDelegate([
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: ProductEmptyVariation(),
        ),
      ]));
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: inventories.length,
          (context, index) {
            var inventory = inventories[index];

            if (inventory.id == null) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Dismissible(
                  onDismissed: (value) {},
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      try {
                        await inventoryService.removeInventoryHive(index);
                        return true;
                      } catch (e) {
                        return false;
                      }
                    }
                    return false;
                  },
                  direction: DismissDirection.endToStart,
                  background: Container(
                    decoration: BoxDecoration(
                        color: DarkModePlatformTheme.negativeLight3,
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 30,
                        child: SvgPicture.asset(
                          "assets/icons/delete.svg",
                          width: 30,
                          height: 30,
                          color: DarkModePlatformTheme.negativeDark1,
                        ),
                      ),
                    ),
                  ),
                  key: UniqueKey(),
                  child: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      final variationService =
                          Provider.of<VariationService>(context, listen: false);
                      var inventoryData = inventories[index];
                      inventoryService.updateInventory(
                        inventoryData,
                        index,
                        variationService.selectedVariations,
                      );

                      showBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        enableDrag: false,
                        builder: (context) => InventorySetupScreen(
                          index: index,
                          newInventory: false,
                        ),
                      );
                    },
                    child: InventoryInputCard(
                      inventory: inventory,
                      index: index,
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }

                    final variationService =
                        Provider.of<VariationService>(context, listen: false);
                    var inventoryData = inventories[index];

                    inventoryService.updateInventory(inventoryData, index,
                        variationService.selectedVariations);

                    showBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      enableDrag: false,
                      builder: (context) => InventorySetupScreen(
                        index: index,
                        newInventory: false,
                      ),
                    );
                  },
                  child: InventoryInputCard(
                    inventory: inventory,
                    index: index,
                  ),
                ),
              );
            }
          },
        ),
      );
    }
  }
}
