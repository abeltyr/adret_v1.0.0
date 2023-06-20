import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconTextCard extends StatelessWidget {
  final String title;
  final Color titleColor;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final String subTitle;
  final Color subTitleColor;
  final double subTitleFontSize;
  final FontWeight subTitleFontWeight;
  final String icon;
  final Color iconColor;
  final double iconSize;
  const IconTextCard({
    Key? key,
    required this.title,
    this.titleColor = DarkModePlatformTheme.grey4,
    this.titleFontSize = 16,
    this.titleFontWeight = FontWeight.w700,
    required this.subTitle,
    this.subTitleColor = DarkModePlatformTheme.grey6,
    this.subTitleFontSize = 16,
    this.subTitleFontWeight = FontWeight.w300,
    required this.icon,
    this.iconColor = DarkModePlatformTheme.grey6,
    this.iconSize = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          width: iconSize,
          height: iconSize,
          child: SvgPicture.asset(
            icon,
            color: iconColor,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: titleFontSize,
                fontWeight: titleFontWeight,
                color: titleColor,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: subTitleFontSize,
                fontWeight: subTitleFontWeight,
                color: subTitleColor,
              ),
            )
          ],
        ),
      ],
    );
  }
}
