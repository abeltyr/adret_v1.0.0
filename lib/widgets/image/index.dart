import 'dart:io';
import 'package:adret/services/image/index.dart';
import 'package:adret/utils/file.dart';
import 'package:adret/widgets/animation/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'error.dart';

class LoadedImageView extends StatefulWidget {
  final String? imageUrl;
  final String? imageFile;
  final BoxFit fitData;

  const LoadedImageView({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.fitData = BoxFit.fill,
  });

  @override
  State<LoadedImageView> createState() => _LoadedImageViewState();
}

class _LoadedImageViewState extends State<LoadedImageView> {
  bool loading = true;
  File? file;
  @override
  void initState() {
    super.initState();
    download(context);
  }

  @override
  void didUpdateWidget(covariant LoadedImageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageFile != widget.imageFile ||
        oldWidget.imageUrl != widget.imageUrl) {
      download(context);
    }
  }

  bool error = false;
  void download(BuildContext context) async {
    var getImageProvider =
        Provider.of<GetImageProvider>(context, listen: false);
    var isGranted = await Permission.storage.isGranted;
    var isPermanentlyDenied = await Permission.storage.isPermanentlyDenied;
    if (Platform.isAndroid && !isGranted && !isPermanentlyDenied) {
      try {
        final res = await Permission.storage.request();
        if (res == PermissionStatus.granted) {
          if (mounted) {
            setState(() {
              error = false;
              loading = false;
            });
          }
        }
        // ignore: empty_catches
      } catch (e) {}
    }

    String filePath = "";
    if (widget.imageUrl != null) {
      filePath = await fileLocation(widget.imageUrl!);
    } else if (widget.imageFile != null) {
      filePath = widget.imageFile!;
    }
    file = File(filePath);
    if (!file!.existsSync() && widget.imageUrl != null) {
      try {
        file = await getImageProvider.fetchImage(
          imageUrl: widget.imageUrl!,
          filePath: filePath,
        );
      } catch (e) {
        file = null;
      }
    } else if (!file!.existsSync() && widget.imageUrl == null) {
      file = null;
    }

    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const AnimationWidget(
        assetData: 'assets/animations/productLoading.json',
        durationData: Duration(milliseconds: 1500),
      );
    } else if ((widget.imageUrl != null && widget.imageFile == null) ||
        ((file == null || (file != null && !file!.existsSync())) && !loading)) {
      return CachedNetworkImage(
        imageUrl: widget.imageUrl ?? "",
        height: 1020,
        width: 1020,
        fit: widget.fitData,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return const AnimationWidget(
            assetData: "assets/animations/productLoading.json",
            durationData: Duration(milliseconds: 1500),
          );
        },
        errorWidget: (context, _, error) {
          return ErrorImage(
            onClick: () {
              if (!mounted) return;
              setState(() {
                loading = true;
                file = null;
              });
              download(context);
            },
            fitData: widget.fitData,
          );
        },
      );
    } else if (file != null && file!.existsSync() && !loading) {
      return Image.file(
        file!,
        cacheHeight: 1020,
        cacheWidth: 1020,
        fit: widget.fitData,
        errorBuilder: (context, _, error) {
          return ErrorImage(
            onClick: () {
              if (!mounted) return;
              setState(() {
                loading = true;
                file = null;
              });
              download(context);
            },
            fitData: widget.fitData,
          );
        },
      );
    } else {
      return ErrorImage(
        onClick: () {
          if (!mounted) return;
          setState(() {
            loading = true;
            file = null;
          });
          download(context);
        },
        fitData: widget.fitData,
      );
    }
  }
}
