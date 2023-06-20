import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotFound extends StatelessWidget {
  final String title;
  final String subText;

  const NotFound({
    Key? key,
    this.title = "No items found",
    this.subText = "The list is currently Empty",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.3,
            child: Lottie.asset(
              'assets/animations/notFound.json',
              fit: BoxFit.fill,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: DarkModePlatformTheme.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subText,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: DarkModePlatformTheme.white,
            ),
          ),
        ],
      ),
    );
  }
}
