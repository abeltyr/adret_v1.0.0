import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/animation/animations.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransitionScreen extends StatelessWidget {
  final String? animation;
  final String? icon;
  final Color iconColor;
  final String? topText;
  final String? subText;
  final List<String>? details;
  final String? actionText;
  final String? actionIcon;
  final Function? action;

  const TransitionScreen({
    super.key,
    this.animation,
    this.icon,
    this.iconColor = DarkModePlatformTheme.white,
    this.topText,
    this.subText,
    this.details,
    this.actionText,
    this.actionIcon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkModePlatformTheme.secondBlack,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (animation != null)
              const AnimationWidget(
                assetData: "assets/animations/noConnection.json",
                durationData: Duration(milliseconds: 2000),
              ),
            if (icon != null)
              SizedBox(
                width: double.infinity,
                child: SvgPicture.asset(
                  icon!,
                  color: iconColor,
                ),
              ),
            if (topText != null)
              Text(
                topText!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  color: DarkModePlatformTheme.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 27,
                  wordSpacing: 1,
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            if (subText != null)
              Text(
                subText!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: DarkModePlatformTheme.white.withOpacity(0.75),
                  fontWeight: FontWeight.w100,
                  fontSize: 18,
                  wordSpacing: 1,
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: details != null ? details!.length : 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 12.5,
                          width: 12.5,
                          decoration: BoxDecoration(
                              color:
                                  DarkModePlatformTheme.white.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            details![index],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color:
                                  DarkModePlatformTheme.white.withOpacity(0.75),
                              fontWeight: FontWeight.w100,
                              fontSize: 18,
                              wordSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (action != null)
              SizedBox(
                height: 45,
                child: MainButton(
                  onClick: () {
                    action!();
                  },
                  title: actionText,
                  color: DarkModePlatformTheme.primaryLight3,
                  textColor: DarkModePlatformTheme.primaryDark2,
                  icon: actionIcon,
                ),
              )
          ],
        ),
      )),
    );
  }
}
