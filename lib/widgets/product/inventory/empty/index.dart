import 'package:adret/services/inventory/index.dart';
import 'package:adret/services/inventory/variation.dart';
import 'package:adret/utils/notification/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/inventory/inputScreen/index.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductEmptyVariation extends StatelessWidget {
  const ProductEmptyVariation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarkModePlatformTheme.fourthBlack,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.variation,
            style: const TextStyle(
              fontFamily: 'Nunito',
              color: DarkModePlatformTheme.grey5,
              fontWeight: FontWeight.w100,
              fontSize: 20,
              wordSpacing: 1,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            AppLocalizations.of(context)!.addInventoryPrompt,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Nunito',
              color: DarkModePlatformTheme.grey5,
              fontWeight: FontWeight.w100,
              fontSize: 14,
              wordSpacing: 1,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            child: MainButton(
                borderRadiusData: 5,
                title: AppLocalizations.of(context)!.addVariation,
                icon: "assets/icons/bold/add.svg",
                onClick: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  final variationService =
                      Provider.of<VariationService>(context, listen: false);
                  final inventoryService =
                      Provider.of<InventoryService>(context, listen: false);
                  if (inventoryService.inventories.length > 10) {
                    errorNotification(
                      context: context,
                      text: AppLocalizations.of(context)!.addInventoryCaution,
                      bottom: 0,
                    );
                    return;
                  }
                  try {
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
                    // ignore: empty_catches
                  } catch (e) {}
                }),
          )
        ],
      ),
    );
  }
}
