import 'package:adret/model/productView/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/media/popup/index.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'card.dart';

class ProductMediaInput extends StatelessWidget {
  final List<MediaViewModel> media;
  const ProductMediaInput({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 35;
    double height = MediaQuery.of(context).size.height / 3.5;
    return Column(
      children: [
        SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (media.isEmpty)
                GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      context: context,
                      builder: (context) => const CameraPopup(),
                    );
                  },
                  child: DottedBorder(
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    color: DarkModePlatformTheme.grey5,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/bold/galleryUpload.svg",
                                width: 90,
                                height: 90,
                                color: DarkModePlatformTheme.grey5,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context)!.uploadProductImage,
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              color: DarkModePlatformTheme.grey5,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              wordSpacing: 1,
                              letterSpacing: 0.5,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              else
                Row(
                  children: [
                    SizedBox(
                      width: (width - 10) * 9 / 12,
                      height: height,
                      child: MediaCard(
                        media: media,
                        index: 0,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: (width - 10) * 3 / 12,
                          height: (height - 15) / 3,
                          child: MediaCard(
                            media: media,
                            index: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 7.5,
                        ),
                        if (media.length >= 2)
                          SizedBox(
                            width: (width - 10) * 3 / 12,
                            height: (height - 15) / 3,
                            child: MediaCard(
                              media: media,
                              index: 2,
                            ),
                          ),
                        const SizedBox(
                          height: 7.5,
                        ),
                        if (media.length >= 3)
                          Container(
                            width: (width - 10) * 3 / 12,
                            height: (height - 15) / 3,
                            alignment: Alignment.center,
                            child: MediaCard(
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
