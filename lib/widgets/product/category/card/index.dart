import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Category extends StatelessWidget {
  final String content;
  final double width;
  final bool showIcon;

  const Category({
    super.key,
    required this.content,
    required this.width,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DarkModePlatformTheme.white,
        borderRadius: BorderRadius.circular(7.5),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3.5,
      ),
      height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showIcon)
            SvgPicture.asset(
              "assets/icons/tag.svg",
              width: 24,
              height: 24,
              color: DarkModePlatformTheme.secondBlack,
            ),
          const SizedBox(
            width: 2.5,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              capitalize(content),
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: DarkModePlatformTheme.secondBlack,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
