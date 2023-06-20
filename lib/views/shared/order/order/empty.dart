import 'package:adret/widgets/empty/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderEmpty extends StatelessWidget {
  const OrderEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: EmptyState(
            emptyIcon: "assets/icons/bold/noOrder.svg",
            height: 150,
            subText: AppLocalizations.of(context)!.goToProduct,
            topText: AppLocalizations.of(context)!.noSales,
          ),
        ),
      ]),
    );
  }
}
