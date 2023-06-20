import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DisplayHeader extends StatelessWidget {
  final Function? iconAction;
  final Function? iconAction1;
  final String? icon;
  final String? icon1;
  final String title;
  final double size;
  final MainAxisAlignment mainAxisAlignment;
  const DisplayHeader({
    super.key,
    required this.title,
    this.icon,
    this.icon1,
    this.iconAction,
    this.iconAction1,
    this.size = 26,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 42.5,
                width: 42.5,
                // padding: const EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/icons/bold/arrowLeftBorder.svg",
                  color: DarkModePlatformTheme.grey5,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: "Nunito",
            fontSize: size,
            fontWeight: FontWeight.w200,
            color: DarkModePlatformTheme.white,
          ),
        ),
        Row(
          children: [
            if (icon != null)
              GestureDetector(
                onTap: () {
                  iconAction!();
                },
                child: SvgPicture.asset(
                  icon!,
                  width: 37.5,
                  height: 37.5,
                  color: DarkModePlatformTheme.accentLight3,
                ),
              )
            else
              const SizedBox(
                width: 37.5,
                height: 37.5,
              ),
            if (icon1 != null)
              const SizedBox(
                width: 12,
              ),
            if (icon1 != null)
              GestureDetector(
                onTap: () {
                  iconAction1!();
                },
                child: SvgPicture.asset(
                  icon1!,
                  width: 40,
                  height: 40,
                  color: DarkModePlatformTheme.white,
                ),
              ),
          ],
        )
      ],
    );
  }
}
