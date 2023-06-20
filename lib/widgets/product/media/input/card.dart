import 'dart:io';

import 'package:adret/model/productView/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/media/index.dart';
import 'package:adret/widgets/image/index.dart';
import 'package:adret/widgets/product/media/popup/index.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MediaCard extends StatelessWidget {
  final List<MediaViewModel> media;
  final int index;
  const MediaCard({
    super.key,
    required this.index,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snapshot) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: media.length > index
            ? GestureDetector(
                onTap: () {
                  showCupertinoModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (context) =>
                        MediaScreen(media: media, initialPage: index),
                  );
                },
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: LoadedImageView(
                        fitData: BoxFit.fitWidth,
                        imageUrl: media[index].url != null
                            ? '${dotenv.get('FILE_URL')}${media[index].url!}'
                            : null,
                        imageFile: media[index].file != null &&
                                File(
                                  media[index].file ?? "",
                                ).existsSync()
                            ? media[index].file!
                            : null,
                      )),
                ),
              )
            : GestureDetector(
                onTap: () {
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
                  radius: const Radius.circular(5),
                  color: DarkModePlatformTheme.white,
                  child: Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/icons/bold/galleryUpload.svg",
                      width: snapshot.maxWidth / 3,
                      height: snapshot.maxWidth / 3,
                      color: DarkModePlatformTheme.white,
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
