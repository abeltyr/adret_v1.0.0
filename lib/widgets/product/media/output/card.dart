import 'package:adret/model/productView/index.dart';
import 'package:adret/widgets/product/media/index.dart';
import 'package:adret/widgets/image/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MediaCardOutput extends StatelessWidget {
  final List<String?> media;
  final int index;
  const MediaCardOutput({
    super.key,
    required this.index,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snapshot) {
      return GestureDetector(
        onTap: () {
          List<MediaViewModel> mediaListing = [];

          for (var mediaData in media) {
            mediaListing = [...mediaListing, MediaViewModel(url: mediaData)];
          }

          showCupertinoModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            context: context,
            builder: (context) => MediaScreen(
              media: mediaListing,
              initialPage: index,
              remove: false,
            ),
          );
        },
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LoadedImageView(
              imageUrl: "${dotenv.get('FILE_URL')}${media[index]}",
              fitData: BoxFit.cover,
            ),
          ),
        ),
      );
    });
  }
}
