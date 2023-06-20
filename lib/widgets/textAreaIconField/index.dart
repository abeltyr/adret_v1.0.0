import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextAreaIconField extends StatelessWidget {
  final String label;
  final String content;
  final String? icon;
  final double ratio1;
  final double ratio2;
  final double size;
  final FontWeight fontWeight;
  final double borderPadding;
  final Color color;
  final bool showIcon;

  const TextAreaIconField({
    Key? key,
    required this.label,
    required this.content,
    this.icon,
    this.ratio1 = 1.2,
    this.ratio2 = 10.8,
    this.size = 25,
    this.borderPadding = 10,
    this.fontWeight = FontWeight.w100,
    this.color = DarkModePlatformTheme.white,
    this.showIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Row(
        crossAxisAlignment:
            showIcon ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: (constrains.maxWidth - 10) * ratio1 / 12,
            child: icon != null
                ? SvgPicture.asset(
                    icon!,
                    width: (constrains.maxWidth - 10) * ratio1 / 12,
                    height: (constrains.maxWidth - 10) * ratio1 / 12,
                    color: color,
                  )
                : const Stack(),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: (constrains.maxWidth - 10) * ratio2 / 12,
            child: Text(
              content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Nunito',
                color: color,
                fontWeight: fontWeight,
                fontSize: size,
                wordSpacing: 0.1,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      );
    });
  }
}
