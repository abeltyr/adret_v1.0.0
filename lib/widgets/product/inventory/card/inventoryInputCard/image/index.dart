import 'package:adret/model/productView/index.dart';
import 'package:adret/services/product/actions/media.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/image/index.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';

class InventoryInputCardImage extends StatefulWidget {
  final int? image;
  const InventoryInputCardImage({
    super.key,
    this.image,
  });

  @override
  State<InventoryInputCardImage> createState() =>
      _InventoryInputCardImageState();
}

class _InventoryInputCardImageState extends State<InventoryInputCardImage> {
  bool loading = true;
  String? url;
  String? file;
  List<MediaViewModel>? media = fetchProductImages();

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  void didUpdateWidget(covariant InventoryInputCardImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setup();
  }

  setup() {
    if (mounted) {
      media = fetchProductImages();
      if (media != null &&
          widget.image != null &&
          media!.length > widget.image!) {
        if (media![widget.image!].file != null) {
          setState(() {
            file = media![widget.image!].file;
            url = null;
          });
        } else if (media![widget.image!].url != null) {
          setState(() {
            url = "${dotenv.get('FILE_URL')}${media![widget.image!].url}";
            file = null;
          });
        }
      } else {
        setState(() {
          file = null;
          url = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: url != null || file != null
          ? SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LoadedImageView(
                  imageFile: file,
                  imageUrl: url,
                  fitData: BoxFit.fill,
                ),
              ),
            )
          : DottedBorder(
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              padding: const EdgeInsets.all(10),
              color: DarkModePlatformTheme.white,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: SvgPicture.asset(
                      "assets/icons/addImage.svg",
                      width: double.infinity,
                      height: double.infinity,
                      color: DarkModePlatformTheme.white,
                    )),
              ),
            ),
    );
  }
}
