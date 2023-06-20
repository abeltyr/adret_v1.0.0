import 'package:adret/client.dart';
import 'package:adret/graphql/order.dart';
import 'package:adret/model/order/index.dart';
import 'package:adret/model/shared.dart';
import 'package:adret/utils/convert/order_convertor.dart';
import 'package:graphql/client.dart';

Future<List<OrderModel>?> fetchOrdersFunction({
  FilterModel? filter,
  String? sellerId,
  String? startDate,
  String? endDate,
  double? maxTotalPrice,
  double? minTotalPrice,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().query(
      QueryOptions(
        document: gql(OrderGraphql.orders),
        variables: {
          "input": {
            "filter": filter!.toMap(),
            "startDate": startDate,
            "endDate": endDate,
            "sellerId": sellerId,
            "maxTotalPrice": maxTotalPrice,
            "minTotalPrice": minTotalPrice
          }
        },
      ),
    );

    if (result.exception != null) {
      throw Exception(result.exception);
    } else if (result.data != null) {
      List<OrderModel> orders = [];
      for (var data in result.data!["orders"]) {
        OrderModel order = orderConverter(data: data);
        orders.add(order);
      }
      return orders;
    }
  } catch (e) {
    throw Exception(e);
  }
  return null;
}
