import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';

class ColumnText extends StatelessWidget {
  final String title;
  final String subText;
  final Color? colorData;
  final FontWeight? titleFontSize;
  final FontWeight? subFontTextSize;
  final double? titleSize;
  final double? subTextSize;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const ColumnText({
    Key? key,
    required this.title,
    required this.subText,
    this.colorData = DarkModePlatformTheme.white,
    this.titleSize = 14,
    this.subTextSize = 12,
    this.titleFontSize = FontWeight.w600,
    this.subFontTextSize = FontWeight.w500,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            capitalize(title),
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: titleSize,
              fontWeight: titleFontSize,
              color: colorData,
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            subText,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: subTextSize,
              fontWeight: subFontTextSize,
              color: colorData,
            ),
          ),
        ),
      ],
    );
  }
}
