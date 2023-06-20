import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImagePopupBox extends StatelessWidget {
  final String title;
  final String icon;
  final Function onClick;
  const ImagePopupBox({
    super.key,
    required this.title,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final double totalWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        width: (totalWidth - 60) / 2,
        height: 135,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: DarkModePlatformTheme.thirdBlack,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: DarkModePlatformTheme.grey6,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: "Nunito",
                color: DarkModePlatformTheme.grey6,
                fontWeight: FontWeight.w200,
                fontSize: 20,
                wordSpacing: 0.5,
                letterSpacing: 0.75,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
