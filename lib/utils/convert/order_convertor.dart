import 'package:adret/model/order/index.dart';
import 'package:adret/model/sales/index.dart';
import 'package:adret/utils/convert/sales_convertor.dart';
import 'package:adret/utils/convert/user_convertor.dart';

OrderModel orderConverter({
  required dynamic data,
}) {
  Map<String, dynamic> orderMap = Map<String, dynamic>.from(data);

  if (orderMap["seller"] != null) {
    var seller = userConverter(data: orderMap["seller"]);
    orderMap["seller"] = seller;
  }

  if (orderMap["sales"] != null) {
    List<SalesModel> sales = [];
    for (var saleData in orderMap["sales"]) {
      var sale = saleConverter(data: saleData);
      sales.add(sale);
    }

    orderMap["sales"] = sales;
  }

  var order = OrderModel.fromJson(orderMap);
  return order;
}
