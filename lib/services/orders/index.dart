import 'package:adret/model/cart/index.dart';
import 'package:adret/model/order/index.dart';
import 'package:adret/model/shared.dart';
import 'package:adret/model/user/index.dart';
import 'package:adret/services/orders/actions/create_order.dart';
import 'package:adret/services/orders/actions/fetch_orders.dart';
import 'package:adret/utils/role.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderService with ChangeNotifier {
  List<OrderModel> _orders = [];
  bool _loading = false;
  RefreshController? _refreshController;

  bool get loading => _loading;
  RefreshController? get refreshController => _refreshController;

  var hiveUserRole = Hive.box('userRole');
  var hiveUser = Hive.box<UserModel>('user');

  List<OrderModel> get orders => _orders;

  DateTime _startDate = DateTime.now();

  DateTime _endDate = DateTime.now().add(const Duration(days: 1));

  String? _sellerId;

  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  String? get sellerId => _sellerId;

  Future<void> reset() async {
    _startDate = DateTime.now();

    _endDate = DateTime.now().add(const Duration(days: 1));
    _sellerId = null;
    _orders = [];
  }

  Future<void> updateStartDate({required DateTime value}) async {
    _startDate = value;
  }

  Future<void> setRefreshController(
      RefreshController refreshControllerData) async {
    _refreshController = refreshControllerData;
  }

  Future<void> updateEndDate({required DateTime value}) async {
    _endDate = value;
  }

  Future<void> updateSellerId({String? value}) async {
    _sellerId = value;
    notifyListeners();
  }

  void resetOrder() {
    _orders = [];
    notifyListeners();
  }

  Future<bool> loadMoreOrder() async {
    String? orderAfter;
    if (_orders.isNotEmpty) {
      orderAfter = _orders[_orders.length - 1].id;
    }
    int fetchSize = 30;

    String start = DateFormat('yyyy-MM-dd').format(_startDate).toString();

    String end = DateFormat('yyyy-MM-dd').format(_endDate).toString();

    UserModel user = hiveUser.get("current", defaultValue: UserModel())!;

    if (!isManager(user.userRole ?? "")) {
      _sellerId = user.id;
      start = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      end = start;
    }

    try {
      List<OrderModel>? loadedOrders = await fetchOrdersFunction(
        filter: FilterModel(
          limit: fetchSize,
          after: orderAfter,
        ),
        startDate: start,
        endDate: end,
        sellerId: _sellerId,
      );
      if (loadedOrders != null) {
        _orders = [..._orders, ...loadedOrders];
        notifyListeners();
      }

      if (loadedOrders != null && loadedOrders.length < fetchSize) {
        return false;
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> refreshOrder() async {
    if (!_loading) {
      if (orders.isEmpty) _loading = true;
      String? orderBefore;
      if (_orders.isNotEmpty) {
        orderBefore = _orders[0].id;
      }

      try {
        String start = DateFormat('yyyy-MM-dd').format(_startDate).toString();

        String end = DateFormat('yyyy-MM-dd').format(_endDate).toString();

        UserModel user = hiveUser.get("current", defaultValue: UserModel())!;

        if (!isManager(user.userRole ?? "")) {
          _sellerId = user.id;
          start = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
          end = start;
        }

        List<OrderModel>? newOrder = await fetchOrdersFunction(
          filter: FilterModel(
            limit: 30,
            before: orderBefore,
          ),
          startDate: start,
          endDate: end,
          sellerId: _sellerId,
        );
        if (newOrder != null) _orders = [...newOrder, ..._orders];
      } catch (e) {
        _loading = false;
        notifyListeners();
        throw Exception(e);
      }

      _loading = false;
      notifyListeners();
    }
  }

  Future<OrderModel?> createOrder({
    required List<CartModel> carts,
    required String note,
  }) async {
    try {
      OrderModel? newOrder = await createOrderFunction(
        carts: carts,
        note: note,
      );

      DateFormat('yyyy-MM-dd').format(_endDate).toString();
      if (newOrder != null && newOrder.date != null) {
        DateTime orderData = DateTime.parse(newOrder.date!);
        if ((sellerId == null ||
                (sellerId != null && sellerId == newOrder.seller!.id)) &&
            (endDate.difference(orderData).inSeconds > 1)) {
          _orders = [newOrder, ..._orders];
          notifyListeners();
          return newOrder;
        }
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
