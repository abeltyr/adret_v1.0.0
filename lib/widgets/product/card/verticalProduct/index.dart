import 'package:adret/model/cart/index.dart';
import 'package:adret/model/input/index.dart';
import 'package:adret/model/product/index.dart';
import 'package:adret/services/cart/index.dart';
import 'package:adret/utils/notification/index.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/card/tag/index.dart';
import 'package:adret/widgets/image/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerticalProduct extends StatefulWidget {
  final ProductModel product;
  final int? index;
  const VerticalProduct({
    Key? key,
    required this.product,
    this.index,
  }) : super(key: key);

  @override
  State<VerticalProduct> createState() => _VerticalProductState();
}

class _VerticalProductState extends State<VerticalProduct> {
  bool showBottom = false;

  @override
  Widget build(BuildContext context) {
    final detailCheck = widget.product.detail != null &&
        widget.product.detail!.isNotEmpty &&
        widget.product.detail!.length > 20;
    return Dismissible(
      movementDuration: const Duration(milliseconds: 850),
      onDismissed: (value) {
        // currentProductService.removeInventoryInput(index: index);
      },
      confirmDismiss: (value) async {
        final cartService = Provider.of<CartService>(context, listen: false);
        if (value == DismissDirection.startToEnd) {
          int available =
              int.tryParse(widget.product.inventory![0].available!) ?? 0;
          int sale =
              int.tryParse(widget.product.inventory![0].salesAmount!) ?? 0;
          int inventoryAmount = available - sale;

          if (inventoryAmount > 0) {
            cartService.addCart(
              CartModel(
                amount: InputModel(input: 1),
                inventory: widget.product.inventory![0],
                productCode: companyNameRemover(widget.product.productCode!),
                title: widget.product.title!,
                sellingPrice: InputModel(
                    input: double.tryParse(widget
                        .product.inventory![0].maxSellingPriceEstimation!)),
                totalPrice: double.tryParse(
                    widget.product.inventory![0].maxSellingPriceEstimation!)!,
                media: widget.product.media != null &&
                        widget.product.media!.isNotEmpty
                    ? widget.product.media![0]
                    : null,
                productIndex: widget.index,
                inventoryIndex: 0,
              ),
            );
            successNotification(
              context: context,
              text: AppLocalizations.of(context)!.cartAdded,
            );
          } else {
            errorNotification(
              context: context,
              text: AppLocalizations.of(context)!.outOfStock,
            );
          }
        }
        return false;
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        decoration: BoxDecoration(
          color: DarkModePlatformTheme.primaryLight2.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 40,
            child: SvgPicture.asset(
              "assets/icons/bold/addCart.svg",
              width: 40,
              height: 40,
              color: DarkModePlatformTheme.secondBlack,
            ),
          ),
        ),
      ),
      key: UniqueKey(),
      resizeDuration: const Duration(milliseconds: 300),
      child: LayoutBuilder(
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 170,
                      maxWidth: snapshot.maxWidth,
                    ),
                    child: LoadedImageView(
                      imageUrl: widget.product.media != null &&
                              widget.product.media!.isNotEmpty
                          ? "${dotenv.get('FILE_URL')}${widget.product.media![0]}"
                          : null,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            TagCard(
                              icon: "assets/icons/bold/box.svg",
                              text: widget.product.inStock ?? "",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TagCard(
                              icon: "assets/icons/bold/moneys.svg",
                              text: priceShow(
                                widget.product.inventory![0]
                                    .maxSellingPriceEstimation,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                capitalize(widget.product.title),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: DarkModePlatformTheme.white,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              if (detailCheck)
                SizedBox(
                  height: 40,
                  child: Text(
                    widget.product.detail!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: DarkModePlatformTheme.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  TagCard(
                    icon: "assets/icons/bold/barcode.svg",
                    text: companyNameRemover(widget.product.productCode!),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  TagCard(
                    icon: "assets/icons/bold/tag.svg",
                    text: widget.product.category ?? "",
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
