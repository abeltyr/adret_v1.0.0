import 'dart:io';

import 'package:adret/services/product/actions/media.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/camera/index.dart';
import 'package:adret/widgets/product/media/popup/box/index.dart';
import 'package:adret/widgets/popup/message/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraPopup extends StatelessWidget {
  const CameraPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    final double totalWidth = MediaQuery.of(context).size.width;
    String? platform;
    if (Platform.isAndroid) {
      platform = "Android";
    } else {
      platform = "IPhone";
    }

    return SizedBox(
      height: 200,
      width: totalWidth,
      child: Scaffold(
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
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  width: 75,
                  height: 5,
                  decoration: BoxDecoration(
                    color: DarkModePlatformTheme.grey5,
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                width: totalWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImagePopupBox(
                      onClick: () async {
                        Navigator.pushNamed(
                          context,
                          CameraScreen.routeName,
                          arguments: {
                            "doneFunction": (List<XFile> value) {
                              addProductImages(value: value);
                            },
                          },
                        );
                      },
                      title: AppLocalizations.of(context)!.takePhoto,
                      icon: "assets/icons/bold/camera.svg",
                    ),
                    ImagePopupBox(
                      onClick: () async {
                        try {
                          var value = await picker.pickMultiImage();
                          addProductImages(value: value);
                        } catch (e) {
                          if (e.toString().contains("photo_access_denied")) {
                            final res = await Permission.photos.request();
                            if (PermissionStatus.permanentlyDenied == res) {
                              // ignore: use_build_context_synchronously
                              showCupertinoDialog(
                                context: context,
                                builder: (_) => MessagePopUp(
                                  cancelColor:
                                      DarkModePlatformTheme.primaryDark1,
                                  acceptColor: DarkModePlatformTheme.grey2,
                                  acceptTextColor: DarkModePlatformTheme.grey5,
                                  cancelTextColor:
                                      DarkModePlatformTheme.primaryLight3,
                                  acceptFunction: () {
                                    openAppSettings();
                                  },
                                  cancelFunction: () {},
                                  title: AppLocalizations.of(context)!
                                      .cameraAccessPrompt,
                                  subText:
                                      "${AppLocalizations.of(context)!.cameraAccessPrompt} ${AppLocalizations.of(context)!.inData} $platform ${AppLocalizations.of(context)!.photoErrorPartTwo}",
                                  cancel: AppLocalizations.of(context)!.latter,
                                  accept:
                                      AppLocalizations.of(context)!.settings,
                                ),
                              );
                            }
                          }
                        }
                      },
                      title: AppLocalizations.of(context)!.photoLibrary,
                      icon: "assets/icons/bold/image.svg",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
