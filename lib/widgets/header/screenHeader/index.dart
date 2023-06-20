import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScreenHeader extends StatelessWidget {
  final Function? iconAction;
  final Function? iconAction1;
  final String? icon;
  final String? icon1;
  final String title;
  const ScreenHeader({
    super.key,
    required this.title,
    this.icon,
    this.icon1,
    this.iconAction,
    this.iconAction1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "Nunito",
            fontSize: 24,
            fontStyle: '${Localizations.localeOf(context)}' == "en"
                ? FontStyle.italic
                : null,
            fontWeight: FontWeight.w800,
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
                  width: 32.5,
                  height: 32.5,
                  color: DarkModePlatformTheme.white,
                ),
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
                  width: 32.5,
                  height: 32.5,
                  color: DarkModePlatformTheme.white,
                ),
              ),
          ],
        )
      ],
    );
  }
}
