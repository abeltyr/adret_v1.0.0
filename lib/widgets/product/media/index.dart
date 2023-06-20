import 'package:adret/model/productView/index.dart';
import 'package:adret/services/product/actions/media.dart';
import 'package:adret/utils/file.dart';
import 'package:adret/widgets/image/index.dart';
import 'package:adret/widgets/popup/message/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adret/utils/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MediaScreen extends StatefulWidget {
  final List<MediaViewModel> media;
  final int initialPage;
  final bool remove;
  const MediaScreen({
    Key? key,
    required this.media,
    this.remove = true,
    this.initialPage = 0,
  }) : super(key: key);

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  late PageController _controller;
  int indexData = 0;
  List<MediaViewModel> mediaData = [];

  @override
  void initState() {
    indexData = widget.initialPage;
    super.initState();
    _controller = PageController(initialPage: widget.initialPage);
    mediaData = [...widget.media];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkModePlatformTheme.secondBlack,
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 3 / 4,
            child: PageView.builder(
              itemCount: mediaData.length,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                indexData = value;
              },
              controller: _controller,
              itemBuilder: (context, index) {
                return LoadedImageView(
                  imageUrl: mediaData[index].url != null
                      ? "${dotenv.get('FILE_URL')}${mediaData[index].url}"
                      : null,
                  imageFile: mediaData[index].file != null
                      ? mediaData[index].file!
                      : null,
                );
              },
            ),
          ),
          if (mediaData.length > indexData)
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 2 / 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (mediaData.length > indexData)
                      SizedBox(
                        child: GestureDetector(
                          onTap: () async {
                            final box =
                                context.findRenderObject() as RenderBox?;

                            String filePath = "";
                            if (mediaData[indexData].url != null) {
                              filePath = await fileLocation(
                                  "${dotenv.get('FILE_URL')}${mediaData[indexData].url!}");
                            } else if (mediaData[indexData].file != null) {
                              filePath = mediaData[indexData].file!;
                            }
                            Share.shareXFiles(
                              [XFile(filePath)],
                              sharePositionOrigin:
                                  box!.localToGlobal(Offset.zero) & box.size,
                              subject: "Product image ${indexData + 1}",
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.height * 1 / 12,
                            height: MediaQuery.of(context).size.height * 1 / 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: DarkModePlatformTheme.grey2,
                            ),
                            padding: const EdgeInsets.all(17.5),
                            child: SvgPicture.asset(
                              "assets/icons/bold/mediaDownload.svg",
                              color: DarkModePlatformTheme.grey6,
                            ),
                          ),
                        ),
                      ),
                    if (widget.remove)
                      GestureDetector(
                        onTap: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (_) => MessagePopUp(
                              cancelColor: DarkModePlatformTheme.negativeDark1,
                              acceptColor: DarkModePlatformTheme.grey2,
                              acceptTextColor: DarkModePlatformTheme.grey5,
                              cancelTextColor:
                                  DarkModePlatformTheme.negativeLight3,
                              acceptFunction: () async {
                                await removeProductImages(index: indexData);
                                mediaData.removeAt(indexData);
                                if (indexData - 1 > 0) {
                                  indexData = indexData - 1;
                                } else {
                                  indexData = 0;
                                }
                                setState(() {});
                                if (mediaData.isEmpty) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                }
                              },
                              cancelFunction: () {},
                              title: AppLocalizations.of(context)!.removeImage,
                              cancel: AppLocalizations.of(context)!.cancel,
                              accept: AppLocalizations.of(context)!.delete,
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.height * 1 / 12,
                          height: MediaQuery.of(context).size.height * 1 / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: DarkModePlatformTheme.negativeLight2,
                          ),
                          padding: const EdgeInsets.all(17.5),
                          child: SvgPicture.asset(
                            "assets/icons/delete.svg",
                            color: DarkModePlatformTheme.negativeDark1,
                          ),
                        ),
                      )
                  ],
                )),
        ],
      ),
    );
  }
}
