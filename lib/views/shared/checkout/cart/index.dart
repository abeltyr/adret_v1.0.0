import 'package:adret/services/cart/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:adret/widgets/image/index.dart';
import 'package:adret/widgets/text/column_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'price/index.dart';

class CartCard extends StatelessWidget {
  final int index;

  const CartCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context, listen: false);
    String? media = cartService.carts[index].inventory.media ??
        cartService.carts[index].media;
    return Container(
      decoration: BoxDecoration(
        color: DarkModePlatformTheme.fourthBlack,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: media != null
                            ? SizedBox(
                                width: 50,
                                height: 50,
                                child: LoadedImageView(
                                  imageUrl: "${dotenv.get('FILE_URL')}$media",
                                ),
                              )
                            : SizedBox(
                                width: 50,
                                height: 50,
                                child: SvgPicture.asset(
                                  "assets/icons/bold/box.svg",
                                  color: DarkModePlatformTheme.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: ColumnText(
                        title: cartService.carts[index].title,
                        subText: cartService.carts[index].productCode,
                        titleFontSize: FontWeight.w500,
                        subFontTextSize: FontWeight.w300,
                        titleSize: 18,
                        subTextSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: MainButton(
                  onClick: () {
                    cartService.removeCart(index);
                    if (cartService.carts.isEmpty) {
                      Navigator.pop(context);
                    } else {
                      // update.value = true;
                    }
                  },
                  borderRadiusData: 7.5,
                  icon: "assets/icons/bold/delete.svg",
                  color: DarkModePlatformTheme.negativeLight3,
                  textColor: DarkModePlatformTheme.negativeDark1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          CheckoutPrice(
            index: index,
          ),
        ],
      ),
    );
  }
}
