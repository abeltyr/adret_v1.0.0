import 'dart:io';

import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/popup/message/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageDisplay extends StatefulWidget {
  final List<XFile> images;
  final Function(int) removeFunction;
  const ImageDisplay({
    super.key,
    required this.images,
    required this.removeFunction,
  });

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  @override
  Widget build(BuildContext context) {
    List<XFile> photos = [...widget.images];

    double height = 200;

    if (widget.images.length > 4 && widget.images.length <= 8) {
      height = 300;
    } else if (widget.images.length > 8 && widget.images.length <= 12) {
      height = 190.0 * (widget.images.length ~/ 4);
    } else if (widget.images.length > 12 && widget.images.length <= 20) {
      height = 150.0 * (widget.images.length ~/ 4);
    } else if (widget.images.length > 20) {
      height = 150.0 * (widget.images.length ~/ 4);
    }

    return SizedBox(
      height: height > MediaQuery.of(context).size.height
          ? MediaQuery.of(context).size.height
          : height,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: DarkModePlatformTheme.secondBlack,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "${photos.length} Uploaded Media",
                      style: const TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: DarkModePlatformTheme.grey5,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 15.0),
                    child: GridView.builder(
                      itemCount: widget.images.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1,
                        crossAxisCount: 4,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 15.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (_) => MessagePopUp(
                                cancelColor:
                                    DarkModePlatformTheme.negativeDark1,
                                acceptColor: DarkModePlatformTheme.grey2,
                                acceptTextColor: DarkModePlatformTheme.grey5,
                                cancelTextColor:
                                    DarkModePlatformTheme.negativeLight3,
                                acceptFunction: () {
                                  widget.removeFunction(index);
                                  photos.removeAt(index);
                                  setState(() {});
                                },
                                cancelFunction: () {},
                                title:
                                    AppLocalizations.of(context)!.removeImage,
                                cancel: AppLocalizations.of(context)!.cancel,
                                accept: AppLocalizations.of(context)!.delete,
                              ),
                            );
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: DarkModePlatformTheme.white,
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: File(
                                    photos[index].path,
                                  ).existsSync()
                                      ? Image.file(
                                          File(
                                            photos[index].path,
                                          ),
                                          cacheHeight: 1020,
                                          cacheWidth: 1020,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/noMedia.webp",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Container(
                                color: DarkModePlatformTheme.black
                                    .withOpacity(0.5),
                                width: double.infinity,
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: SvgPicture.asset(
                                    "assets/icons/delete.svg",
                                    width: 25,
                                    height: 25,
                                    color: DarkModePlatformTheme.negativeLight3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              width: 75,
              height: 5,
              decoration: BoxDecoration(
                color: DarkModePlatformTheme.darkWhite,
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
