import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/avatar/index.dart';
import 'package:adret/widgets/text/column_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HorizontalCard extends StatelessWidget {
  final bool active;
  final String title;
  final String subText;
  final double titleSize;
  final double subTextSize;
  final FontWeight titleFontWeight;
  final FontWeight subTextFontWeight;
  final String? icon;
  const HorizontalCard({
    super.key,
    required this.active,
    required this.title,
    required this.subText,
    this.titleSize = 18,
    this.subTextSize = 13,
    this.titleFontWeight = FontWeight.w600,
    this.subTextFontWeight = FontWeight.w100,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: active ? DarkModePlatformTheme.grey1 : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: DarkModePlatformTheme.grey1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: icon != null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: active
                          ? DarkModePlatformTheme.grey5
                          : DarkModePlatformTheme.fourthBlack,
                    ),
                    width: 55,
                    height: 55,
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      icon!,
                      color: active
                          ? DarkModePlatformTheme.grey1
                          : DarkModePlatformTheme.grey6,
                    ),
                  )
                : SizedBox(
                    width: 50,
                    height: 50,
                    child: TextAvatar(
                      textData: title,
                      fontSize: 20,
                      color: active
                          ? DarkModePlatformTheme.grey6
                          : DarkModePlatformTheme.grey3,
                      textColor: active
                          ? DarkModePlatformTheme.grey6
                          : DarkModePlatformTheme.grey3,
                    ),
                  ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: ColumnText(
              title: title,
              subText: subText,
              titleSize: titleSize,
              subTextSize: subTextSize,
              titleFontSize: titleFontWeight,
              subFontTextSize: subTextFontWeight,
              colorData: DarkModePlatformTheme.grey6,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
