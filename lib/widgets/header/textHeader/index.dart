import 'package:adret/utils/text.dart';
import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class TextHeader extends StatelessWidget {
  final bool showActionText;
  final bool showCloseText;
  final String actionText;
  final String closeText;
  final String centerText;
  final bool divider;
  final bool closeAction;
  final bool cover;
  final Function? actionFunction;
  final Function? closeFunction;

  const TextHeader({
    super.key,
    this.showActionText = true,
    this.showCloseText = true,
    this.closeAction = true,
    this.divider = true,
    this.cover = false,
    this.actionText = "Save",
    this.closeText = "Cancel",
    this.centerText = "",
    this.actionFunction,
    this.closeFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
      ),
      height: 60,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (cover)
                const SizedBox(
                  width: 8,
                ),
              GestureDetector(
                onTap: () {
                  if (showCloseText) {
                    if (closeFunction != null) closeFunction!();
                    if (closeAction) Navigator.pop(context);
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: cover
                        ? DarkModePlatformTheme.fourthBlack
                        : Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: cover ? 12 : 16,
                    vertical: 4,
                  ),
                  child: Text(
                    capitalize(closeText),
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: showCloseText
                          ? DarkModePlatformTheme.white
                          : Colors.transparent,
                      fontWeight: FontWeight.w200,
                      fontSize: 18,
                      wordSpacing: 0.1,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    centerText,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      color: DarkModePlatformTheme.white,
                      fontWeight: FontWeight.w100,
                      fontSize: 18,
                      wordSpacing: 0.1,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (showActionText && actionFunction != null) {
                    actionFunction!();
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: showActionText && cover
                        ? DarkModePlatformTheme.primaryLight3
                        : Colors.transparent,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Text(
                    capitalize(actionText),
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        color: showActionText
                            ? cover
                                ? DarkModePlatformTheme.primaryDark2
                                : DarkModePlatformTheme.primaryLight2
                            : Colors.transparent,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        wordSpacing: 0.6,
                        letterSpacing: 0.3),
                  ),
                ),
              ),
              if (cover)
                const SizedBox(
                  width: 8,
                ),
            ],
          ),
          if (divider)
            const SizedBox(
              height: 10,
            ),
          if (divider)
            const Divider(
              color: DarkModePlatformTheme.darkWhite,
              height: 1,
            )
        ],
      ),
    );
  }
}
