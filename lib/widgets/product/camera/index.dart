import 'dart:io';

import 'package:adret/utils/notification/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/camera/capture/index.dart';
import 'package:adret/widgets/animation/animations.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:adret/widgets/header/textHeader/index.dart';
import 'package:adret/widgets/product/media/screen/index.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraScreen extends StatefulWidget {
  static const routeName = '/camera';

  const CameraScreen({
    super.key,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription camera;
  bool locked = false;
  bool cameraError = false;
  List<XFile> photos = [];
  double zoomLevel = 1;
  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = getCameraData();
  }

  Future getCameraData() async {
    final cameras = await availableCameras();

    // create a CameraController.
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    try {
      await _controller!.initialize();
    } on CameraException catch (error) {
      if (error.code == "CameraAccessDeniedWithoutPrompt") {
        var res = await Permission.camera.request();
        if (res.isDenied || res.isPermanentlyDenied) {
          setState(() {
            cameraError = true;
          });
        }
      } else {
        setState(() {
          cameraError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    if (_controller != null) _controller!.dispose();
    super.dispose();
  }

  void zoom() {
    if (zoomLevel == 1) {
      zoomLevel = 2;
    } else {
      zoomLevel = 1;
    }
    _controller!.setZoomLevel(zoomLevel);
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: DarkModePlatformTheme.secondBlack,
        body: SafeArea(
          child: Column(
            children: [
              TextHeader(
                actionText: AppLocalizations.of(context)!.add,
                closeText: AppLocalizations.of(context)!.back,
                actionFunction: () {
                  final arguments = ModalRoute.of(context)!.settings.arguments
                      as Map<String, dynamic>;
                  var doneFunction =
                      arguments["doneFunction"] as Function(List<XFile>);

                  doneFunction(photos);
                  Navigator.pop(context);
                },
                divider: false,
              ),
              FutureBuilder(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      _controller != null &&
                      !cameraError) {
                    // If the Future is complete, display the preview.
                    return Column(
                      children: [
                        GestureDetector(
                          onLongPress: () {
                            _controller!.setExposureMode(ExposureMode.locked);
                            _controller!.setFocusMode(FocusMode.locked);
                            setState(() {
                              locked = true;
                            });
                          },
                          onLongPressEnd: (data) {
                            setState(() {
                              locked = false;
                            });
                          },
                          onTap: () {
                            _controller!.setExposureMode(ExposureMode.auto);
                            _controller!.setFocusMode(FocusMode.auto);
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CameraPreview(_controller!),
                              ),
                              if (locked)
                                const Positioned(
                                  bottom: 10,
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                  child: SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: AnimationWidget(
                                      assetData: "assets/animations/focus.json",
                                      durationData:
                                          Duration(milliseconds: 1250),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      zoom();
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: DarkModePlatformTheme.grey5,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        "${zoomLevel.toInt()}x",
                                        style: const TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: DarkModePlatformTheme.grey5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showCupertinoModalBottomSheet(
                                          context: context,
                                          backgroundColor:
                                              DarkModePlatformTheme.secondBlack,
                                          builder: (context) => ImageDisplay(
                                            images: photos,
                                            removeFunction: (index) async {
                                              await File(photos[index].path)
                                                  .delete();

                                              setState(() {
                                                photos.removeAt(index);
                                              });
                                            },
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        height:
                                            (MediaQuery.of(context).size.width /
                                                5),
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                5),
                                        child: Stack(children: [
                                          if (photos.isNotEmpty)
                                            SizedBox(
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5),
                                              width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: File(
                                                  photos[photos.length - 1]
                                                      .path,
                                                ).existsSync()
                                                    ? Image.file(
                                                        File(
                                                          photos[photos.length -
                                                                  1]
                                                              .path,
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
                                          if (photos.isNotEmpty)
                                            Container(
                                              decoration: BoxDecoration(
                                                color: DarkModePlatformTheme
                                                    .grey3
                                                    .withOpacity(0.35),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${photos.length}",
                                                style: const TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 27.5,
                                                  fontWeight: FontWeight.w500,
                                                  color: DarkModePlatformTheme
                                                      .grey6,
                                                ),
                                              ),
                                            ),
                                        ]),
                                      ),
                                    ),
                                    CaptureButton(
                                      loading: loading,
                                      onClick: () async {
                                        if (!loading) {
                                          setState(() {
                                            loading = true;
                                          });
                                          if (Platform.isIOS) {
                                            _controller!.pausePreview();
                                          }
                                          try {
                                            final data = await _controller!
                                                .takePicture();
                                            photos.add(data);
                                            // ignore: empty_catches
                                          } catch (e) {
                                            errorNotification(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .errorNotification,
                                              context: context,
                                            );
                                          }
                                          if (Platform.isIOS) {
                                            _controller!.resumePreview();
                                          }

                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          (MediaQuery.of(context).size.width /
                                              5),
                                      width:
                                          (MediaQuery.of(context).size.width /
                                              5),
                                      // color: DarkModePlatformTheme.white50,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      (_controller == null || cameraError)) {
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 115,
                              width: MediaQuery.of(context).size.width,
                              child: SvgPicture.asset(
                                "assets/icons/noCamera.svg",
                                width: 18,
                                height: 18,
                                color: DarkModePlatformTheme.grey5,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!.cameraAccessDenied,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                color: DarkModePlatformTheme.grey5,
                                fontWeight: FontWeight.w200,
                                fontSize: 18,
                                wordSpacing: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!.goToGiveAccess,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                color: DarkModePlatformTheme.grey3,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                wordSpacing: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: MainButton(
                                    onClick: () {
                                      openAppSettings();
                                    },
                                    horizontalPadding: 15,
                                    borderRadiusData: 10,
                                    title: AppLocalizations.of(context)!
                                        .openSetting,
                                    textFontSize: 20,
                                    textColor: DarkModePlatformTheme.primary,
                                    color: Colors.transparent,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 115,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            child: Lottie.asset(
                              'assets/animations/loading.json',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
