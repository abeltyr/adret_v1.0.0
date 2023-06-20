import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';

class ColumnTextLoading extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  const ColumnTextLoading({
    super.key,
    this.color = DarkModePlatformTheme.secondBlack,
    this.width = 90,
    this.height = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width,
          height: height + 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: width * 2 / 3,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
          ),
        ),
      ],
    );
  }
}
