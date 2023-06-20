import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';

class TextAvatar extends StatelessWidget {
  final String textData;
  final double fontSize;
  final Color color;
  final Color textColor;

  const TextAvatar({
    Key? key,
    required this.textData,
    this.fontSize = 24,
    this.color = DarkModePlatformTheme.grey6,
    this.textColor = DarkModePlatformTheme.secondBlack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Text(
        avatarCut(textData),
        style: TextStyle(
          fontFamily: 'Nunito',
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
