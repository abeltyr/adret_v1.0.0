import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final bool active;
  final String title;
  final String subText;
  final double titleSize;
  final double subTextSize;
  final FontWeight titleFontWeight;
  final FontWeight subTextFontWeight;
  final String? icon;
  const UserCard({
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
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: active ? DarkModePlatformTheme.grey1 : Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: active
                    ? DarkModePlatformTheme.grey5
                    : DarkModePlatformTheme.fourthBlack,
                borderRadius: BorderRadius.circular(10)),
            child: Text(avatarCut(title),
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: active
                      ? DarkModePlatformTheme.grey1
                      : DarkModePlatformTheme.grey5,
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  wordSpacing: 1,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            child: Column(
              children: [
                Text(capitalize(title),
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      color: DarkModePlatformTheme.grey6,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      wordSpacing: 1,
                    )),
                const SizedBox(
                  height: 6,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(subText,
                      style: const TextStyle(
                        color: DarkModePlatformTheme.grey6,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        wordSpacing: 1,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
