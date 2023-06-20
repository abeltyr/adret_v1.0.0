import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconText extends StatelessWidget {
  final String text;
  final String icon;
  final double size;
  final Color color;
  const IconText({
    super.key,
    required this.icon,
    required this.text,
    this.size = 16,
    this.color = DarkModePlatformTheme.white,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snapshot) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            icon,
            width: size + 2,
            height: size + 2,
            color: color,
          ),
          const SizedBox(
            width: 4,
          ),
          SizedBox(
            width: text.length * (size - 8) > snapshot.maxWidth - 10 - size
                ? snapshot.maxWidth - 10 - size
                : text.length * (size - 8),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: size,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
