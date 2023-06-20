import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/animation/animations.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DataFetcherHeader extends StatelessWidget {
  const DataFetcherHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return WaterDropHeader(
      completeDuration: const Duration(milliseconds: 2000),
      complete: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 40,
              width: 40,
              child: AnimationWidget(
                repeat: false,
                assetData: 'assets/animations/success.json',
                durationData: Duration(milliseconds: 1000),
              )),
        ],
      ),
      failed: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
            width: 30,
            child: AnimationWidget(
              assetData: 'assets/animations/errorIcon.json',
              repeat: false,
              durationData: Duration(milliseconds: 1500),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            AppLocalizations.of(context)!.errorNotification,
            style: const TextStyle(
              fontFamily: "Nunito",
              color: DarkModePlatformTheme.negativeLight2,
              fontWeight: FontWeight.w800,
              fontSize: 14,
              wordSpacing: 0.5,
            ),
          ),
        ],
      ),
      refresh: const AnimationWidget(
        assetData: 'assets/animations/loading.json',
        durationData: Duration(milliseconds: 2500),
      ),
      waterDropColor: Colors.transparent,
      idleIcon: const AnimationWidget(
        assetData: 'assets/animations/loading.json',
        durationData: Duration(milliseconds: 2500),
      ),
    );
  }
}
