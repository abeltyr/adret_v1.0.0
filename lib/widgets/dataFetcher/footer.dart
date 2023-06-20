import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/animation/animations.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DataFetcherFooter extends StatelessWidget {
  const DataFetcherFooter({super.key});

  final style = const TextStyle(
    fontFamily: 'Nunito',
    color: DarkModePlatformTheme.white,
    fontWeight: FontWeight.w600,
    fontSize: 13,
    wordSpacing: 0.1,
  );
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text(
            AppLocalizations.of(context)!.pullUpLoad,
            style: const TextStyle(
              fontFamily: "Nunito",
              color: DarkModePlatformTheme.darkWhite,
              fontWeight: FontWeight.w300,
              fontSize: 14,
              wordSpacing: 0.5,
            ),
          );
        } else if (mode == LoadStatus.loading) {
          body = const AnimationWidget(
            assetData: 'assets/animations/productLoading.json',
            durationData: Duration(milliseconds: 2500),
          );
        } else if (mode == LoadStatus.failed) {
          body = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
                width: 30,
                child: AnimationWidget(
                  assetData: 'assets/animations/errorIcon.json',
                  repeat: false,
                  durationData: Duration(milliseconds: 750),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                AppLocalizations.of(context)!.loadFailMessage,
                style: const TextStyle(
                  fontFamily: "Nunito",
                  color: DarkModePlatformTheme.negative,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  wordSpacing: 0.5,
                ),
              ),
            ],
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Text(
            AppLocalizations.of(context)!.leasePullLoad,
            style: const TextStyle(
              fontFamily: "Nunito",
              color: DarkModePlatformTheme.darkWhite,
              fontWeight: FontWeight.w300,
              fontSize: 14,
              wordSpacing: 0.5,
            ),
          );
        } else {
          body = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
                width: 30,
                child: AnimationWidget(
                  assetData: "assets/animations/emptyBox.json",
                  durationData: Duration(milliseconds: 1750),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                AppLocalizations.of(context)!.noMoreData,
                style: const TextStyle(
                  fontFamily: "Nunito",
                  color: DarkModePlatformTheme.darkWhite,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  wordSpacing: 0.5,
                ),
              ),
            ],
          );
        }
        return SizedBox(
          height: 75.0,
          child: Center(child: body),
        );
      },
    );
  }
}
