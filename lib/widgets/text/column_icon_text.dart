import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColumnIconText extends StatelessWidget {
  final String title;
  final String subText;
  final String? titleIcon;
  final String? subTextIcon;
  final Color? colorData;
  final FontWeight? titleFontSize;
  final FontWeight? subFontTextSize;
  final double? titleSize;
  final double? subTextSize;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const ColumnIconText({
    Key? key,
    required this.title,
    required this.subText,
    this.titleIcon,
    this.subTextIcon,
    this.colorData = DarkModePlatformTheme.white,
    this.titleSize = 19,
    this.subTextSize = 15,
    this.titleFontSize = FontWeight.w600,
    this.subFontTextSize = FontWeight.w300,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (titleIcon != null)
              SvgPicture.asset(
                titleIcon!,
                width: titleSize,
                height: titleSize,
                color: DarkModePlatformTheme.white,
              ),
            if (titleIcon != null)
              const SizedBox(
                width: 5,
              ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    capitalize(title),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: titleSize,
                      fontWeight: titleFontSize,
                      color: colorData,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (subTextIcon != null)
              SvgPicture.asset(
                subTextIcon!,
                width: subTextSize,
                height: subTextSize,
                color: DarkModePlatformTheme.white,
              ),
            if (subTextIcon != null)
              const SizedBox(
                width: 5,
              ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    subText,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: subTextSize,
                      fontWeight: subFontTextSize,
                      color: colorData,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
