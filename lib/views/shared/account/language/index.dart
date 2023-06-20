import 'package:adret/services/language.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:adret/widgets/header/displayHeader/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  static const routeName = '/languageScreen';
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService =
        Provider.of<LanguageService>(context, listen: false);

    const languageData = [
      {"title": "English", "locale": "en"},
      {"title": "Amharic", "locale": "am"},
    ];
    return Scaffold(
      backgroundColor: DarkModePlatformTheme.secondBlack,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: [
            DisplayHeader(
              title: AppLocalizations.of(context)!.languages,
              size: 22,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 2,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(top: 16),
                  height: 60,
                  child: MainButton(
                    onClick: () {
                      final langData = languageData[index]["locale"] ?? "en";
                      languageService.changeLanguage(langData);
                    },
                    borderRadiusData: 5,
                    color: '${Localizations.localeOf(context)}' ==
                            languageData[index]["locale"]
                        ? DarkModePlatformTheme.grey5
                        : DarkModePlatformTheme.grey1,
                    textColor: '${Localizations.localeOf(context)}' ==
                            languageData[index]["locale"]
                        ? DarkModePlatformTheme.secondBlack
                        : DarkModePlatformTheme.white.withOpacity(0.5),
                    title: languageData[index]["title"],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
