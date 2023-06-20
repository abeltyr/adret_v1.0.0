import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavbarButton extends StatelessWidget {
  final String activeIcon;
  final String icon;
  final String title;
  final bool active;
  final double width;
  final Function click;
  const NavbarButton({
    Key? key,
    required this.activeIcon,
    required this.icon,
    required this.title,
    required this.active,
    required this.width,
    required this.click,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click();
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: active ? 35 : 33.5,
              height: active ? 35 : 33.5,
              duration: const Duration(milliseconds: 250),
              child: SvgPicture.asset(
                active ? activeIcon : icon,
                fit: BoxFit.fill,
                color: active
                    ? DarkModePlatformTheme.white
                    : DarkModePlatformTheme.white.withOpacity(0.75),
              ),
            ),
            const SizedBox(
              height: 2.5,
            ),
            // AnimatedContainer(
            //   duration: const Duration(milliseconds: 250),
            //   child: Text(
            //     title,
            //     style: TextStyle(
            //       fontFamily: 'Nunito',
            //       fontSize: 13,
            //       fontWeight: FontWeight.w600,
            //       color: active
            //           ? DarkModePlatformTheme.primaryDark
            //           : DarkModePlatformTheme.fourthDark,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
