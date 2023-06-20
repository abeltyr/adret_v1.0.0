import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/price/input/header/checkbox/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PriceHeader extends StatelessWidget {
  final Function rangeClick;
  final bool range;
  const PriceHeader({
    super.key,
    required this.rangeClick,
    required this.range,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.pricing,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Nunito',
            color: DarkModePlatformTheme.white,
            fontWeight: FontWeight.w100,
            fontSize: 18,
            wordSpacing: 0.1,
            letterSpacing: 0.5,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: DarkModePlatformTheme.white,
          ),
          padding: const EdgeInsets.only(right: 5),
          child: PriceRangeCheckBox(
            onClick: () {
              rangeClick();
            },
            active: range,
          ),
        ),
      ],
    );
  }
}
