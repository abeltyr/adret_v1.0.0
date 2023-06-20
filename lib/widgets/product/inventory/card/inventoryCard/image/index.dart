import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/image/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';

class InventoryCardImage extends StatefulWidget {
  final String? image;
  const InventoryCardImage({
    super.key,
    this.image,
  });

  @override
  State<InventoryCardImage> createState() => _InventoryCardImageState();
}

class _InventoryCardImageState extends State<InventoryCardImage> {
  String? media;

  @override
  void initState() {
    super.initState();
    if (widget.image != null && mounted) {
      setState(() {
        media = "${dotenv.get('FILE_URL')}${widget.image}";
      });
    }
  }

  @override
  void didUpdateWidget(covariant InventoryCardImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.image != oldWidget.image) {
      setState(() {
        media = "${dotenv.get('FILE_URL')}${widget.image}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: media != null
          ? SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LoadedImageView(
                  imageUrl: media!,
                ),
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/bold/media.svg",
                width: double.infinity,
                height: double.infinity,
                color: DarkModePlatformTheme.white,
              ),
            ),
    );
  }
}
