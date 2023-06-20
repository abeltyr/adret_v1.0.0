import 'package:adret/client.dart';
import 'package:adret/graphql/product.dart';
import 'package:adret/model/product/index.dart';
import 'package:adret/model/shared.dart';
import 'package:adret/utils/convert/product_convertor.dart';
import 'package:graphql/client.dart';

Future<dynamic> fetchProductsFunction({
  FilterModel? filter,
  bool? topSelling,
  String? category,
  String? code,
  String? title,
  String? creatorId,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().query(
      QueryOptions(
        document: gql(ProductGraphql.products),
        variables: {
          "input": {
            "category": category,
            "creatorId": creatorId,
            "filter": filter!.toMap(),
            "topSelling": topSelling,
            "code": code,
            "title": title,
          }
        },
      ),
    );

    if (result.exception != null) {
      throw Exception(result.exception);
    } else if (result.data != null) {
      List<ProductModel> products = [];
      for (var data in result.data!["products"]) {
        ProductModel product = productConverter(
          data: data,
        );
        products.add(product);
      }

      return products;
    }
  } catch (e) {
    throw Exception(e);
  }
}
