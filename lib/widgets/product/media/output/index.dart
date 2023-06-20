import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/media/output/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductMediaOutput extends StatelessWidget {
  final List<String> media;
  const ProductMediaOutput({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    double height = MediaQuery.of(context).size.height / 3.5;
    return Column(
      children: [
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (media.isEmpty)
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 1, color: DarkModePlatformTheme.white)),
                    width: width,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/bold/media.svg",
                              width: 90,
                              height: 90,
                              color: DarkModePlatformTheme.white,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.mediaErrorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            color: DarkModePlatformTheme.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            wordSpacing: 1,
                            letterSpacing: 0.5,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              else
                Row(
                  children: [
                    SizedBox(
                      width: media.length == 1
                          ? (width - 5)
                          : (width - 10) * 9 / 12,
                      height: height,
                      child: MediaCardOutput(
                        media: media,
                        index: 0,
                      ),
                    ),
                    if (media.length != 1)
                      const SizedBox(
                        width: 10,
                      ),
                    Column(
                      children: [
                        if (media.length > 1)
                          SizedBox(
                            width: (width - 10) * 3 / 12,
                            height: (height - 15) / 3,
                            child: MediaCardOutput(
                              media: media,
                              index: 1,
                            ),
                          ),
                        const SizedBox(
                          height: 7.5,
                        ),
                        if (media.length > 2)
                          SizedBox(
                            width: (width - 10) * 3 / 12,
                            height: (height - 15) / 3,
                            child: MediaCardOutput(
                              media: media,
                              index: 2,
                            ),
                          ),
                        const SizedBox(
                          height: 7.5,
                        ),
                        if (media.length > 3)
                          Container(
                            width: (width - 10) * 3 / 12,
                            height: (height - 15) / 3,
                            alignment: Alignment.center,
                            child: MediaCardOutput(
                              media: media,
                              index: 3,
                            ),
                          ),
                      ],
                    )
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
