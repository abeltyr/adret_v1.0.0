import 'package:adret/model/inventory/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/inventory/card/inventoryCard/image/index.dart';
import 'package:adret/widgets/text/column_icon_text.dart';
import 'package:adret/widgets/text/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InventoryCard extends StatefulWidget {
  final InventoryModel inventory;
  final int index;

  const InventoryCard({
    Key? key,
    required this.inventory,
    required this.index,
  }) : super(key: key);

  @override
  State<InventoryCard> createState() => _InventoryCardState();
}

class _InventoryCardState extends State<InventoryCard> {
  String titleData = "";
  int leftAmount = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (mounted) {
      String title = "";

      if (widget.inventory.inventoryVariation != null) {
        for (var variation in widget.inventory.inventoryVariation!) {
          String value = variation.data ?? "";
          title =
              "$title${title.isNotEmpty && value.isNotEmpty ? ' - ' : ''}$value";
        }
      }
      if (title.isNotEmpty) {
        titleData = title;
      } else {
        titleData =
            "${AppLocalizations.of(context)!.variation}-#${widget.index}";
      }
      int available = int.tryParse(widget.inventory.available ?? "0") ?? 0;
      int sales = int.tryParse(widget.inventory.salesAmount ?? "0") ?? 0;

      leftAmount = available - sales;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: DarkModePlatformTheme.fourthBlack,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: InventoryCardImage(image: widget.inventory.media),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 70) / 2,
                height: 60,
                child: ColumnIconText(
                  title: titleData,
                  subText: leftAmount.toString(),
                  subTextIcon: "assets/icons/square.svg",
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  subTextSize: 18,
                  titleSize: 20,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.inventory.initialPrice != null)
                    IconText(
                      icon: "assets/icons/bold/moneySend.svg",
                      text:
                          widget.inventory.minSellingPriceEstimation.toString(),
                    ),
                  if (widget.inventory.initialPrice != null)
                    const SizedBox(
                      height: 8,
                    ),
                  if (widget.inventory.maxSellingPriceEstimation != null)
                    IconText(
                      icon: "assets/icons/bold/moneySend.svg",
                      text:
                          widget.inventory.maxSellingPriceEstimation.toString(),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
