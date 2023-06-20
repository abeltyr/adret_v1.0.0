import 'package:adret/model/inventoryInput/index.dart';
import 'package:adret/services/inventory/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/price/input/index.dart';
import 'package:adret/widgets/product/amount/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InventoryDetail extends StatelessWidget {
  final int index;
  const InventoryDetail({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final inventoryService =
        Provider.of<InventoryService>(context, listen: false);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.available,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  color: DarkModePlatformTheme.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 20,
                  wordSpacing: 0.1,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ProductAmountInput(
                amountFunction: (value) {
                  InventoryInputModel data =
                      inventoryService.inventories[index];
                  data.amount.input = value;
                  inventoryService.updateInventory(data, index, null);
                },
                minAmount: inventoryService.inventories[index].sales == 0
                    ? 1
                    : inventoryService.inventories[index].sales ?? 1,
                amount: inventoryService.inventories[index].amount,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ProductPriceInput(
          backgroundColor: DarkModePlatformTheme.fourthBlack,
          initialPriceFunction: (value) {
            InventoryInputModel data = inventoryService.inventories[index];
            data.initialPrice.input = value;
            inventoryService.updateInventory(data, index, null);
            inventoryService.saveInventory();
          },
          sellingPriceFunction: (minSellingPrice, maxSellingPrice) {
            InventoryInputModel data = inventoryService.inventories[index];
            data.maxSellingPriceEstimation = maxSellingPrice;
            data.minSellingPriceEstimation = minSellingPrice;
            inventoryService.updateInventory(data, index, null);
            inventoryService.saveInventory();
          },
          initialPriceValue: inventoryService.inventories[index].initialPrice,
          maxSellingPriceValue:
              inventoryService.inventories[index].maxSellingPriceEstimation,
          minSellingPriceValue:
              inventoryService.inventories[index].minSellingPriceEstimation,
        ),
      ],
    );
  }
}
