import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:flutter/material.dart';

class MessagePopUp extends StatelessWidget {
  final String title;
  final String? subText;
  final String cancel;
  final String accept;
  final Function? acceptFunction;
  final Function? cancelFunction;
  final Color acceptColor;
  final Color cancelColor;
  final Color acceptTextColor;
  final Color cancelTextColor;
  final Color textColor;
  const MessagePopUp({
    required this.title,
    this.subText,
    required this.cancel,
    required this.accept,
    this.cancelFunction,
    this.acceptFunction,
    this.cancelColor = DarkModePlatformTheme.negativeDark1,
    this.acceptColor = DarkModePlatformTheme.positiveDark1,
    this.cancelTextColor = DarkModePlatformTheme.negativeLight3,
    this.acceptTextColor = DarkModePlatformTheme.positiveLight3,
    this.textColor = DarkModePlatformTheme.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: totalWidth,
        height: totalHeight,
        color: Colors.transparent,
        // margin: EdgeInsets.symmetric(
        //   horizontal: (totalWidth - 330) / 2,
        //   vertical: (totalHeight -
        //           (subText == null
        //               ? 100
        //               : (subText!.length / 30) * 50 < 120
        //                   ? (subText!.length / 30) * 50
        //                   : 120)) /
        //       2,
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: DarkModePlatformTheme.secondBlack,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Nunito",
                            color: textColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            wordSpacing: 0.5,
                            height: 1.5,
                          ),
                        ),
                        if (subText != null)
                          const SizedBox(
                            height: 10,
                          ),
                        if (subText != null)
                          Text(
                            subText!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Nunito",
                              color: textColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                              wordSpacing: 0.5,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: subText != null ? 16 : 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 35,
                          width: 125,
                          child: MainButton(
                            color: acceptColor,
                            textColor: acceptTextColor,
                            onClick: () {
                              Navigator.pop(context);
                              cancelFunction!();
                            },
                            textFontSize: 16,
                            title: cancel,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          width: 125,
                          child: MainButton(
                            color: cancelColor,
                            textColor: cancelTextColor,
                            onClick: () {
                              Navigator.pop(context);
                              acceptFunction!();
                            },
                            textFontSize: 16,
                            title: accept,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
