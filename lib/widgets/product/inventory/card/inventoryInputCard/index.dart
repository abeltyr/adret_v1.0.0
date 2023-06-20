import 'package:adret/model/inventoryInput/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/inventory/card/inventoryInputCard/image/index.dart';
import 'package:adret/widgets/text/column_icon_text.dart';
import 'package:adret/widgets/text/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InventoryInputCard extends StatefulWidget {
  final InventoryInputModel inventory;
  final int index;

  const InventoryInputCard({
    Key? key,
    required this.inventory,
    required this.index,
  }) : super(key: key);

  @override
  State<InventoryInputCard> createState() => _InventoryInputCardState();
}

class _InventoryInputCardState extends State<InventoryInputCard> {
  String titleData = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    update();
  }

  @override
  void didUpdateWidget(covariant InventoryInputCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    update();
  }

  update() {
    if (mounted) {
      String title = "";
      if (widget.inventory.title != null) {
        for (var data in widget.inventory.title!) {
          title =
              "$title${title.isNotEmpty && data.value.input.isNotEmpty ? ' - ' : ''}${data.value.input}";
        }
      }
      if (title.isNotEmpty) {
        titleData = title;
      } else {
        titleData =
            "${AppLocalizations.of(context)!.variation}-#${widget.index}";
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 74,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: DarkModePlatformTheme.fourthBlack,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: InventoryInputCardImage(image: widget.inventory.media),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 70) / 2,
                height: double.infinity,
                child: ColumnIconText(
                  title: titleData,
                  subText: widget.inventory.amount.input.toString(),
                  subTextIcon: "assets/icons/square.svg",
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  subTextSize: 18,
                  titleSize: 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.inventory.initialPrice.input != null)
                    IconText(
                      icon: "assets/icons/bold/moneyReceive.svg",
                      text: widget.inventory.initialPrice.input.toString(),
                    ),
                  if (widget.inventory.initialPrice.input != null)
                    const SizedBox(
                      height: 10,
                    ),
                  if (widget.inventory.maxSellingPriceEstimation.input != null)
                    IconText(
                      icon: "assets/icons/bold/moneySend.svg",
                      text: widget.inventory.maxSellingPriceEstimation.input
                          .toString(),
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
