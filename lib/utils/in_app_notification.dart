import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/animation/animations.dart';
import 'package:flutter/material.dart';

class InAppNotification {
  showNotification({
    required BuildContext context,
    required String text,
    double bottom = 20,
    double vertical = 15,
    double size = 20,
    double animationSize = 30,
    Color color = DarkModePlatformTheme.positive,
    Color textColor = DarkModePlatformTheme.white,
    String? icon,
    Duration duration = const Duration(milliseconds: 1000),
    bool loading = false,
    bool repeat = true,
  }) {
    double height = (text.length ~/ 40) * size;
    CrossAxisAlignment crossAxisAlignmentData = CrossAxisAlignment.start;

    if ('${Localizations.localeOf(context)}' == "en") {
      if (text.length <= 34) {
        height = 35;
        crossAxisAlignmentData = CrossAxisAlignment.center;
      } else if (text.length > 34 && text.length <= 88) {
        height = 55;
      } else if (text.length > 88 && text.length <= 125) {
        height = 70;
      } else if (text.length > 125 && text.length <= 165) {
        height = 90;
      } else {
        height = size * 5.3;
      }
    } else {
      if (text.length <= 25) {
        height = 35;
        crossAxisAlignmentData = CrossAxisAlignment.center;
      } else if (text.length > 25 && text.length <= 55) {
        height = 50;
      } else if (text.length > 55 && text.length <= 75) {
        height = 70;
      } else if (text.length > 75 && text.length <= 125) {
        height = 100;
      } else if (text.length > 125 && text.length <= 165) {
        height = 135;
      } else {
        height = size * 10;
      }
    }
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        margin: EdgeInsets.only(bottom: bottom, right: 20, left: 20),
        elevation: 10,
        key: UniqueKey(),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        content: Container(
          height: height + vertical,
          padding:
              height > 40 ? EdgeInsets.symmetric(vertical: vertical) : null,
          child: LayoutBuilder(builder: (context, snapshot) {
            return Row(
              crossAxisAlignment: crossAxisAlignmentData,
              children: [
                if (loading)
                  SizedBox(
                    width: animationSize,
                    height: animationSize,
                    child: const AnimationWidget(
                      assetData: 'assets/animations/productLoading.json',
                      durationData: Duration(milliseconds: 2500),
                    ),
                  ),
                if (!loading && icon != null)
                  SizedBox(
                    height: animationSize,
                    child: AnimationWidget(
                      assetData: icon,
                      repeat: repeat,
                      durationData: const Duration(milliseconds: 1000),
                    ),
                  ),
                if (loading || icon != null)
                  const SizedBox(
                    width: 5,
                  ),
                Expanded(
                  child: Text(
                    text,
                    maxLines: 5,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Nunito",
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: size,
                      wordSpacing: 1,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
