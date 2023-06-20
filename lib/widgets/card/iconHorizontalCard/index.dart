import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconHorizontalCard extends StatelessWidget {
  final String text;
  final String icon;
  final Function onClick;
  const IconHorizontalCard({
    super.key,
    this.text = "Settings",
    this.icon = "assets/icons/bold/settings.svg",
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: DarkModePlatformTheme.grey1,
          border: Border.all(
            width: 0.25,
            color: DarkModePlatformTheme.black,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    icon,
                    color: DarkModePlatformTheme.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: DarkModePlatformTheme.white,
                        fontWeight: FontWeight.w900,
                        fontSize: '${Localizations.localeOf(context)}' == "en"
                            ? 20
                            : 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
