import 'package:adret/services/cart/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/checkout/bottom/index.dart';
import 'package:adret/widgets/empty/index.dart';
import 'package:adret/widgets/header/textHeader/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../loading/index.dart';
import 'cart/index.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/checkout';
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context, listen: true);

    return Scaffold(
      backgroundColor: DarkModePlatformTheme.secondBlack,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          padding: MediaQuery.of(context).viewInsets,
          child: Stack(
            children: [
              Column(
                children: [
                  TextHeader(
                    centerText: AppLocalizations.of(context)!.checkout,
                    closeText: AppLocalizations.of(context)!.close,
                    showActionText: false,
                  ),
                  if (cartService.carts.isNotEmpty)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: cartService.carts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CartCard(
                                index: index,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  if (cartService.carts.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: CheckoutBottom(
                        cartService: cartService,
                      ),
                    ),
                  if (cartService.carts.isEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 150),
                      child: EmptyState(
                        emptyIcon: "assets/icons/order.svg",
                        height: 150,
                        topText: AppLocalizations.of(context)!.emptyCart,
                        subText: AppLocalizations.of(context)!.emptyCartDetail,
                      ),
                    )
                ],
              ),
              if (cartService.loading)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: LoadingScreen(
                    color: DarkModePlatformTheme.grey5.withOpacity(0.5),
                    duration: const Duration(milliseconds: 500),
                    minHeight: 300,
                    maxHeight: 450,
                  ),
                ),
              // if (cartService.carts.isNotEmpty)
              //   Padding(
              //     padding: const EdgeInsets.only(
              //       left: 20,
              //       right: 20,
              //     ),
              //     child: CheckoutBottom(
              //       cartService: cartService,
              //     ),
              //   ),
              // if (cartService.carts.isEmpty)
              //   Container(
              //     margin: const EdgeInsets.only(top: 150),
              //     child:  EmptyState(
              //       emptyIcon: "assets/icons/order.svg",
              //       topText: AppLocalizations.of(context)!.emptyCheckoutMessage,
              //       subText:
              //           AppLocalizations.of(context)!.emptyCheckoutMessage,
              //     ),
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
