import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:flutter/material.dart';

class SliderHeader extends StatelessWidget {
  final int index;
  final String icon;
  final String text;
  final String icon1;
  final String text1;
  final Function(int) updateIndex;

  const SliderHeader({
    super.key,
    required this.index,
    required this.icon,
    required this.text,
    required this.icon1,
    required this.text1,
    required this.updateIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 40,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: (MediaQuery.of(context).size.width - 30) / 2,
              margin: EdgeInsets.only(
                  left: index == 1
                      ? (MediaQuery.of(context).size.width - 30) / 2
                      : 0),
              decoration: BoxDecoration(
                color: DarkModePlatformTheme.thirdBlack,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Row(children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 30) / 2,
                child: MainButton(
                  onClick: () {
                    updateIndex(0);
                  },
                  color: Colors.transparent,
                  textColor: DarkModePlatformTheme.grey5,
                  icon: icon,
                  title: text,
                  textFontSize:
                      '${Localizations.localeOf(context)}' == "en" ? 20 : 18,
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 30) / 2,
                child: MainButton(
                  onClick: () {
                    updateIndex(1);
                  },
                  color: Colors.transparent,
                  textColor: DarkModePlatformTheme.grey5,
                  icon: icon1,
                  title: text1,
                  textFontSize:
                      '${Localizations.localeOf(context)}' == "en" ? 20 : 18,
                ),
              )
            ]),
          ],
        ));
  }
}
