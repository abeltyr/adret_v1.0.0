import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextIconField extends StatelessWidget {
  final String? label;
  final String icon;
  final String content;
  final double ratio1;
  final double ratio2;
  final double size;
  final Color color;
  final FontWeight fontWeight;

  final double borderPadding;

  const TextIconField({
    Key? key,
    this.label,
    required this.icon,
    required this.content,
    this.ratio1 = 1.2,
    this.ratio2 = 10.8,
    this.size = 25,
    this.borderPadding = 10,
    this.fontWeight = FontWeight.w300,
    this.color = DarkModePlatformTheme.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null && label!.isNotEmpty)
            SizedBox(
              key: const ValueKey<int>(0),
              width: constrains.maxWidth,
              child: Text(
                label!,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: color,
                  fontWeight: fontWeight,
                  fontSize: size * 10 / 12,
                  wordSpacing: 0.1,
                ),
              ),
            ),
          const SizedBox(
            height: 7.5,
          ),
          Row(
            children: [
              SizedBox(
                width: (constrains.maxWidth - 10) * ratio1 / 12,
                child: SvgPicture.asset(
                  icon,
                  width: (constrains.maxWidth - 10) * ratio1 / 12,
                  height: (constrains.maxWidth - 10) * ratio1 / 12,
                  color: color,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (constrains.maxWidth - 10) * ratio2 / 12,
                child: Text(
                  content,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: color,
                    fontWeight: fontWeight,
                    fontSize: size,
                    wordSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
