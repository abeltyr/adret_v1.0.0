import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TagCard extends StatelessWidget {
  final String icon;
  final double iconSize;
  final Color iconColor;
  final String text;
  final double textFontSize;
  final Color textColor;
  final FontWeight textFontWeight;
  final double? maxWidth;

  const TagCard({
    super.key,
    required this.icon,
    required this.text,
    this.textColor = DarkModePlatformTheme.white,
    this.textFontSize = 12,
    this.textFontWeight = FontWeight.w600,
    this.iconSize = 14,
    this.iconColor = DarkModePlatformTheme.white,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: DarkModePlatformTheme.accentLight3.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: SvgPicture.asset(
              icon,
              width: 8,
              height: 8,
              fit: BoxFit.fill,
              color: iconColor,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Container(
            constraints: maxWidth != null
                ? BoxConstraints(maxWidth: maxWidth! - 12)
                : null,
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'Nunito',
                color: textColor,
                fontWeight: textFontWeight,
                fontSize: textFontSize,
                wordSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
