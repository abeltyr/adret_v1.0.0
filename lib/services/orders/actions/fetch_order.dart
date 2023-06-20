import 'package:adret/client.dart';
import 'package:adret/graphql/order.dart';
import 'package:adret/model/order/index.dart';
import 'package:adret/utils/convert/order_convertor.dart';
import 'package:graphql/client.dart';

Future<OrderModel?> fetchOrderFunction({
  required String id,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().query(
      QueryOptions(
        document: gql(OrderGraphql.order),
        variables: {
          "orderId": id,
        },
      ),
    );

    if (result.exception != null) {
      throw Exception(result.exception);
    } else if (result.data != null) {
      OrderModel order = orderConverter(
        data: result.data!["order"],
      );
      return order;
    }
  } catch (e) {
    throw Exception(e);
  }
  return null;
}
