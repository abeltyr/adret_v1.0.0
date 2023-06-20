import 'package:adret/model/order/index.dart';
import 'package:adret/model/summary/index.dart';
import 'package:adret/model/user/index.dart';
import 'package:adret/services/summary/collect_summary.dart';
import 'package:adret/services/summary/summary.dart';
import 'package:adret/services/summary/employee_summary.dart';
import 'package:adret/utils/role.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class SummaryService with ChangeNotifier {
  SummaryModel _summary = SummaryModel(earning: "0", profit: "0");
  var hiveUser = Hive.box<UserModel>('user');

  bool _loading = false;
  SummaryModel get summary => _summary;
  bool get loading => _loading;

  Future<void> reset() async {
    _summary = SummaryModel(earning: "0", profit: "0");
    _loading = false;
  }

  Future<void> fetchSummary({
    String? sellerId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      late SummaryModel summaryData;

      String start = DateFormat('yyyy-MM-dd').format(startDate).toString();

      String end = DateFormat('yyyy-MM-dd').format(endDate).toString();

      UserModel user = hiveUser.get("current", defaultValue: UserModel())!;

      if (!isManager(user.userRole ?? "")) {
        sellerId = user.id;
        start = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
        end = start;
      }

      if (summary.id == null) _loading = true;
      if (sellerId == null) {
        summaryData =
            await fetchSummaryFunction(startDate: start, endDate: end);
      } else {
        summaryData = await fetchEmploySummaryFunction(
          date: start,
          employeeId: sellerId,
        );
      }

      _summary = summaryData;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();
      throw Exception(e);
    }
  }

  Future<void> collectSummary() async {
    try {
      UserModel user = hiveUser.get("current", defaultValue: UserModel())!;
      if (_summary.id != null && isManager(user.userRole ?? "")) {
        SummaryModel summaryData =
            await collectSummaryFunction(id: _summary.id!);
        _summary = summaryData;

        notifyListeners();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void addSummary(OrderModel order) {
    double earning = double.tryParse(_summary.earning!) ?? 0;
    double profit = double.tryParse(_summary.profit!) ?? 0;
    double totalProfit = double.tryParse(order.totalProfit!) ?? 0;
    double totalPrice = double.tryParse(order.totalPrice!) ?? 0;
    _summary.earning = (earning + totalPrice).toStringAsFixed(1);
    _summary.profit = (profit + totalProfit).toStringAsFixed(1);
    notifyListeners();
  }

  void resetSummary() {
    _summary = SummaryModel();
    notifyListeners();
  }
}
