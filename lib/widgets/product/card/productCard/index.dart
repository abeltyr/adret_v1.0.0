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

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final int? index;
  final Function onClick;
  const ProductCard({
    Key? key,
    required this.product,
    required this.onClick,
    this.index,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool showBottom = false;

  void addToCart(index) {
    final cartService = Provider.of<CartService>(context, listen: false);
    int available =
        int.tryParse(widget.product.inventory![index].available!) ?? 0;
    int sale = int.tryParse(widget.product.inventory![index].salesAmount!) ?? 0;
    int left = available - sale;

    if (left > 0) {
      cartService.addCart(
        CartModel(
          amount: InputModel(input: 1),
          inventory: widget.product.inventory![0],
          productCode: companyNameRemover(widget.product.productCode!),
          title: widget.product.title!,
          sellingPrice: InputModel(
              input: double.tryParse(
                  widget.product.inventory![0].maxSellingPriceEstimation!)),
          totalPrice: double.tryParse(
              widget.product.inventory![0].maxSellingPriceEstimation!)!,
          media:
              widget.product.media != null && widget.product.media!.isNotEmpty
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

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      movementDuration: const Duration(milliseconds: 450),
      onDismissed: (value) {
        // currentProductService.removeInventoryInput(index: index);
      },
      confirmDismiss: (value) async {
        if (value == DismissDirection.startToEnd) {
          if (widget.product.inventory == null) {
            errorNotification(
              context: context,
              text: AppLocalizations.of(context)!.outOfStock,
            );
            return false;
          }

          if (widget.product.inventory!.length == 1) {
            addToCart(0);
          } else if (widget.product.inventory!.length > 1) {
            widget.onClick();
          }
        }
        return false;
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        decoration: BoxDecoration(
          color: DarkModePlatformTheme.primary,
          borderRadius: BorderRadius.circular(10),
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
              color: DarkModePlatformTheme.primaryDark2,
            ),
          ),
        ),
      ),
      key: UniqueKey(),
      resizeDuration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () {
          widget.onClick();
        },
        child: Container(
          decoration: BoxDecoration(
            color: DarkModePlatformTheme.fourthBlack,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: LayoutBuilder(
            builder: (context, snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 75,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: widget.product.media != null &&
                                widget.product.media!.isNotEmpty
                            ? SizedBox(
                                width: snapshot.maxWidth * 2 / 12,
                                height: double.infinity,
                                child: LoadedImageView(
                                  fitData: BoxFit.cover,
                                  imageUrl:
                                      "${dotenv.get('FILE_URL')}${widget.product.media![0]}",
                                ),
                              )
                            : SizedBox(
                                width: snapshot.maxWidth * 2 / 12,
                                height: double.infinity,
                                child: SvgPicture.asset(
                                  "assets/icons/bold/box.svg",
                                  color: DarkModePlatformTheme.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            capitalize(widget.product.title),
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: DarkModePlatformTheme.grey5,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        // if (detailCheck)
                        //   SizedBox(
                        //     height: 30,
                        //     child: Text(
                        //       widget.product.detail!,
                        //       maxLines: 3,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: const TextStyle(
                        //         fontSize: 10,
                        //         fontWeight: FontWeight.w300,
                        //         color: DarkModePlatformTheme.grey5,
                        //         height: 1,
                        //       ),
                        //     ),
                        //   ),
                        LayoutBuilder(builder: (context, snapshot) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TagCard(
                                maxWidth: (snapshot.maxWidth - 8) * 0.359,
                                text: companyNameRemover(
                                    widget.product.productCode),
                                icon: "assets/icons/bold/barcode.svg",
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              TagCard(
                                maxWidth: (snapshot.maxWidth - 8) * 0.518,
                                text: capitalize(widget.product.category),
                                icon: "assets/icons/bold/tag.svg",
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TagCard(
                        text: widget.product.inStock!,
                        icon: "assets/icons/bold/box.svg",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (widget.product.inventory != null &&
                          widget.product.inventory!.isNotEmpty)
                        TagCard(
                          text: priceShow(
                            widget.product.inventory![0]
                                .maxSellingPriceEstimation,
                          ),
                          iconSize: 16,
                          icon: "assets/icons/bold/moneys.svg",
                        ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
