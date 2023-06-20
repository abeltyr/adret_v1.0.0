import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconColumnText extends StatelessWidget {
  final String icon;
  final String title;
  final String subText;
  final Color iconColor;
  final Color color;
  final Color topTextColor;
  final Color subTextColor;
  final double ration1;
  final double ration2;
  final double width;
  final double paddingSize;
  final double titleFontSize;
  final double subsTextFontSize;
  final FontWeight titleFontWeight;
  final FontWeight subtextFontWeight;
  const IconColumnText({
    super.key,
    required this.icon,
    required this.title,
    required this.subText,
    this.iconColor = DarkModePlatformTheme.white,
    this.topTextColor = DarkModePlatformTheme.white,
    this.color = Colors.transparent,
    this.subTextColor = DarkModePlatformTheme.white,
    required this.width,
    this.paddingSize = 10,
    this.titleFontSize = 17.0,
    this.subsTextFontSize = 16.0,
    this.ration1 = 3,
    this.ration2 = 7,
    this.titleFontWeight = FontWeight.w600,
    this.subtextFontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Container(
            width: width * ration1 / 10,
            height: width * ration1 / 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
            ),
            child: Padding(
              padding: EdgeInsets.all(paddingSize),
              child: SvgPicture.asset(
                icon,
                color: iconColor,
              ),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          SizedBox(
            width: (width * ration2 / 10) - 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: titleFontSize,
                      color: topTextColor,
                      fontWeight: titleFontWeight,
                      letterSpacing: 0.6,
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
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: subsTextFontSize,
                      fontWeight: subtextFontWeight,
                      color: subTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
