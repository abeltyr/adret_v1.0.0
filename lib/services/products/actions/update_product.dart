import 'dart:io';

import 'package:adret/client.dart';
import 'package:adret/graphql/product.dart';
import 'package:adret/model/product/index.dart';
import 'package:adret/model/productView/index.dart';
import 'package:adret/utils/convert/product_convertor.dart';
import 'package:adret/utils/error/image.dart';
import 'package:camera/camera.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

Future<dynamic> updateProductsFunction(ProductViewModel hiveData) async {
  try {
    var inventoryData = [];
    for (var data in hiveData.inventory!) {
      var variationData = [];

      if (data.title != null) {
        for (var value in data.title!) {
          variationData.add({
            "title": value.title,
            "data": value.value.input,
          });
        }
      }
      inventoryData.add({
        "initialPrice": data.initialPrice.input,
        "minSellingPriceEstimation": data.minSellingPriceEstimation.input,
        "maxSellingPriceEstimation": data.maxSellingPriceEstimation.input,
        "variation": variationData,
        "amount": data.amount.input,
        "media": data.media,
        "id": data.id,
      });
    }

    bool exit = false;
    int count = 0;
    List<int> imageIndex = [];

    List<Map<String, dynamic>> mediaData = [];
    for (var data in hiveData.media!) {
      if (data.file != null && File(data.file!).existsSync()) {
        XFile file = XFile(data.file!);
        var name = file.path.split(".");

        final byteData = await file.readAsBytes();

        if (byteData.length > 10000000) {
          exit = true;
          imageIndex.add(count + 1);
        }

        final multipartFile = MultipartFile.fromBytes(
          "photo",
          byteData,
          filename:
              '${DateTime.now().microsecondsSinceEpoch}.${data.file![data.file!.length - 1]}',
          contentType: MediaType("image", name[name.length - 1]),
        );
        mediaData.add({"file": multipartFile, "url": null});
        count++;
      } else if (data.url != null) {
        mediaData.add({"file": null, "url": data.url});
        count++;
      }
    }

    if (exit) {
      throw ImageSizeException(
          "product media-${imageIndex.toString()} to large. Please replace ${imageIndex.length > 1 ? "Them" : "it"}");
    }

    final QueryResult result = await Config.initializeClient().mutate(
      MutationOptions(
        document: gql(ProductGraphql.updateProduct),
        variables: {
          "input": {
            "category": hiveData.category!.input,
            "inventory": inventoryData,
            "detail": hiveData.detail != null ? hiveData.detail!.input : "",
            "title": hiveData.title!.input,
            "media": mediaData,
            "id": hiveData.id
          },
        },
      ),
    );

    if (result.exception != null) {
      throw Exception(result.exception);
    } else if (result.data != null) {
      ProductModel product = productConverter(
        data: result.data!["updateProduct"],
      );
      for (var data in hiveData.media!) {
        if (data.file != null && File(data.file!).existsSync()) {
          File(data.file!).delete();
        }
      }
      return product;
    }
  } catch (e) {
    throw Exception(e);
  }
}
