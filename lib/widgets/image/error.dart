import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorImage extends StatelessWidget {
  final BoxFit fitData;
  final Function? onClick;

  const ErrorImage({
    super.key,
    this.fitData = BoxFit.fill,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClick != null) onClick!();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          "assets/images/reloadImage.png",
          fit: BoxFit.cover,
          color: DarkModePlatformTheme.white,
        ),
      ),
    );
  }
}
