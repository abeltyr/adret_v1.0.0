import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adret/utils/theme.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);
  static const routeName = '/error';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: DarkModePlatformTheme.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      alignment: Alignment.center,
      child: Lottie.asset(
        'assets/animations/error.json',
        fit: BoxFit.fill,
      ),
    );
  }
}
