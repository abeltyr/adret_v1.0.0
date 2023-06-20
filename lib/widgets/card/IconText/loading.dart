import 'dart:math';

import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';

class IconTextCardLoading extends StatelessWidget {
  final double size;
  const IconTextCardLoading({
    Key? key,
    this.size = 28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 55 + (Random().nextInt(40).toDouble());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: DarkModePlatformTheme.grey3,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 105,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: DarkModePlatformTheme.grey3,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              width: width,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: DarkModePlatformTheme.grey3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
