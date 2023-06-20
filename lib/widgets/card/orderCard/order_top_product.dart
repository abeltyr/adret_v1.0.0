import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderTopProduct extends StatelessWidget {
  final String orderNumber;
  final String productCount;
  final String sellerName;
  const OrderTopProduct({
    Key? key,
    required this.orderNumber,
    required this.productCount,
    required this.sellerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                strokeWidth: 1,
                color: DarkModePlatformTheme.grey5,
                padding: const EdgeInsets.all(8),
                radius: const Radius.circular(10),
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: SvgPicture.asset(
                    "assets/icons/orderTick.svg",
                    color: DarkModePlatformTheme.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          AppLocalizations.of(context)!.order,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: DarkModePlatformTheme.grey5,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '#${companyNameRemover(orderNumber)}',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: DarkModePlatformTheme.grey5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: SvgPicture.asset(
                          "assets/icons/bold/product.svg",
                          color: DarkModePlatformTheme.grey5,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          productCount,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: DarkModePlatformTheme.grey5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: DarkModePlatformTheme.fourthBlack,
          ),
          alignment: Alignment.center,
          child: Text(
            avatarCut(sellerName),
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: DarkModePlatformTheme.white,
            ),
          ),
        ),
      ],
    );
  }
}
