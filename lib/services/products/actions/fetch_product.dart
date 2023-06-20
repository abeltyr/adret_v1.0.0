import 'package:adret/client.dart';
import 'package:adret/graphql/product.dart';
import 'package:adret/model/product/index.dart';
import 'package:adret/utils/convert/product_convertor.dart';
import 'package:graphql/client.dart';

Future<dynamic> fetchProductFunction({
  required String id,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().query(
      QueryOptions(
          document: gql(ProductGraphql.product), variables: {"productId": id}),
    );

    if (result.exception != null) {
      throw Exception(result.exception);
    } else if (result.data != null) {
      ProductModel product = productConverter(
        data: result.data!["product"],
      );
      return product;
    }
  } catch (e) {
    throw Exception(e);
  }
}
