import 'package:adret/utils/in_app_notification.dart';
import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';

void errorNotification({
  required String text,
  required BuildContext context,
  double bottom = 55,
  duration = const Duration(milliseconds: 5000),
}) {
  InAppNotification().showNotification(
    context: context,
    text: text,
    color: DarkModePlatformTheme.negativeDark1,
    textColor: DarkModePlatformTheme.negativeLight3,
    bottom: bottom,
    vertical: 5,
    size: 16,
    animationSize: 30,
    icon: "assets/animations/errorIcon.json",
    repeat: false,
    duration: duration,
  );
}

void successNotification({
  required String text,
  required BuildContext context,
  double bottom = 55,
  duration = const Duration(milliseconds: 1000),
}) {
  InAppNotification().showNotification(
    context: context,
    text: text,
    color: DarkModePlatformTheme.positiveDark1,
    textColor: DarkModePlatformTheme.positiveLight3,
    bottom: bottom,
    vertical: 5,
    size: 16,
    animationSize: 35,
    icon: "assets/animations/success.json",
    repeat: false,
    duration: duration,
  );
}
