import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class GetImageProvider with ChangeNotifier {
  List<String> downloadedFiles = [];

  Future<File?> fetchImage({
    required String imageUrl,
    required String filePath,
  }) async {
    try {
      File? fileData = File(filePath);
      if (!await fileData.exists()) {
        final ByteData imageData =
            await NetworkAssetBundle(Uri.parse(imageUrl)).load("");
        final Uint8List bytes = imageData.buffer.asUint8List();
        fileData = await fileData.writeAsBytes(bytes);
        return fileData;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
