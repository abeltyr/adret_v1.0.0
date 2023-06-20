import 'package:adret/model/productView/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/animation/animations.dart';
import 'package:adret/widgets/image/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InventoryImageSelection extends StatefulWidget {
  final List<MediaViewModel> images;
  final int? selectedIndex;
  final Function(int) setFunction;
  final Function() removeFunction;
  const InventoryImageSelection({
    super.key,
    required this.images,
    this.selectedIndex,
    required this.setFunction,
    required this.removeFunction,
  });

  @override
  State<InventoryImageSelection> createState() =>
      _InventoryImageSelectionState();
}

class _InventoryImageSelectionState extends State<InventoryImageSelection> {
  int? selected;
  @override
  void initState() {
    super.initState();
    selected = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    List<MediaViewModel> photos = [...widget.images];

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
                color: DarkModePlatformTheme.black,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "${photos.length} ${AppLocalizations.of(context)!.product} ${AppLocalizations.of(context)!.media}",
                      style: const TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: DarkModePlatformTheme.white,
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
                            if (selected == index) {
                              widget.removeFunction();
                              setState(() {
                                selected = null;
                              });
                            } else {
                              widget.setFunction(index);
                              setState(() {
                                selected = index;
                              });
                            }
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: DarkModePlatformTheme.white,
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: LoadedImageView(
                                    imageUrl: photos[index].url != null
                                        ? "${dotenv.get('FILE_URL')}${photos[index].url}"
                                        : null,
                                    imageFile: photos[index].file,
                                    fitData: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (selected != null && selected == index)
                                const Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: AnimationWidget(
                                        assetData:
                                            "assets/animations/select.json",
                                        repeat: false,
                                        durationData:
                                            Duration(milliseconds: 400),
                                      )),
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
                color: DarkModePlatformTheme.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
