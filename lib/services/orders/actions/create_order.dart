import 'package:adret/client.dart';
import 'package:adret/graphql/order.dart';
import 'package:adret/model/cart/index.dart';
import 'package:adret/model/order/index.dart';
import 'package:adret/utils/convert/order_convertor.dart';
import 'package:graphql/client.dart';

Future<OrderModel?> createOrderFunction({
  required List<CartModel> carts,
  required String note,
}) async {
  List<Map<String, dynamic>> salesInputs = [];

  for (var cart in carts) {
    var salesInput = {
      "amount": cart.amount.input,
      "inventoryId": cart.inventory.id,
      "sellingPrice": cart.sellingPrice.input
    };
    salesInputs.add(salesInput);
  }

  try {
    final QueryResult result = await Config.initializeClient().mutate(
      MutationOptions(
        document: gql(OrderGraphql.createOrder),
        variables: {
          "input": {
            "salesInput": salesInputs,
            "note": note,
          }
        },
      ),
    );

    if (result.exception != null) {
      throw Exception(result.exception);
    } else if (result.data != null) {
      OrderModel order = orderConverter(data: result.data!["createLocalOrder"]);
      return order;
    }
  } catch (e) {
    throw Exception(e);
  }

  return null;
}
