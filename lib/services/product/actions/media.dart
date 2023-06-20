import 'dart:io';

import 'package:adret/model/productView/index.dart';
import 'package:adret/utils/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

var hiveProduct = Hive.box<ProductViewModel>('productView');

List<MediaViewModel>? fetchProductImages() {
  ProductViewModel hiveData =
      hiveProduct.get("currentProduct", defaultValue: ProductViewModel())!;

  return hiveData.media;
}

void addProductImages({required List<XFile> value}) {
  List<XFile> valueData = [...value];

  ProductViewModel hiveData =
      hiveProduct.get("currentProduct", defaultValue: ProductViewModel())!;

  List<MediaViewModel> productImageData = hiveData.media ?? [];

  List<MediaViewModel> newData = [];
  for (var data in valueData) {
    newData = [...newData, MediaViewModel(file: data.path)];
  }

  productImageData = [...productImageData, ...newData];

  if (productImageData.length >= 4) {
    productImageData = [...productImageData.sublist(0, 4)];
  }

  hiveData.media = productImageData;
  hiveProduct.put(
    "currentProduct",
    hiveData,
  );
}

Future<void> removeProductImages({required int index}) async {
  ProductViewModel? hiveData =
      hiveProduct.get("currentProduct", defaultValue: ProductViewModel());
  if (hiveData != null && hiveData.media != null) {
    List<MediaViewModel> productImageData = hiveData.media!;
    if (productImageData[index].file != null) {
      var fileData = File(productImageData[index].file!);
      if (fileData.existsSync()) {
        await fileData.delete();
      }
    } else if (productImageData[index].url != null) {
      String filePath = await fileLocation(
          "${dotenv.get('FILE_URL')}${productImageData[index].url}");
      var fileData = File(filePath);
      if (fileData.existsSync()) {
        await fileData.delete();
      }
      imageCache.clearLiveImages();
      imageCache.clear();
    }
    productImageData.removeAt(index);

    hiveData.media = productImageData;
    hiveProduct.put("currentProduct", hiveData);
  }
}
