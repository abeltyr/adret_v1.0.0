import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyProductView extends StatelessWidget {
  const EmptyProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: SvgPicture.asset(
            "assets/icons/bold/box.svg",
            width: 150,
            height: 150,
            color: DarkModePlatformTheme.darkWhite,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          AppLocalizations.of(context)!.fetchDataError,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Nunito',
            color: DarkModePlatformTheme.white,
            fontWeight: FontWeight.w200,
            fontSize: 22,
            wordSpacing: 1,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          AppLocalizations.of(context)!.closeOrReloadPage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Nunito',
            color: DarkModePlatformTheme.white.withOpacity(0.6),
            fontWeight: FontWeight.w200,
            fontSize: 18,
            wordSpacing: 1,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        // Container(
        //   constraints: const BoxConstraints(maxWidth: 300),
        //   // width: 150,
        //   height: 40,
        //   child: MainButton(
        //     onClick: () {},
        //     icon: "assets/icons/productLoading.svg",
        //     title: AppLocalizations.of(context)!.reload,
        //     textFontSize: 24,
        //     borderRadiusData: 5,
        //     horizontalPadding: 10,
        //   ),
        // )
      ],
    );
  }
}
