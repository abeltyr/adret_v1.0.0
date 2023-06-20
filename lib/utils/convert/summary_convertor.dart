import 'package:adret/model/summary/index.dart';
import 'package:adret/model/user/index.dart';

SummaryModel summaryConverter({
  required dynamic data,
}) {
  Map<String, dynamic> summaryMap = Map<String, dynamic>.from(data);

  if (summaryMap["manager"] != null) {
    Map<String, dynamic> userMap =
        Map<String, dynamic>.from(summaryMap["manager"]);
    var user = UserModel.fromJson(userMap);
    summaryMap["manager"] = user;
  }

  if (summaryMap["employee"] != null) {
    Map<String, dynamic> userMap =
        Map<String, dynamic>.from(summaryMap["employee"]);
    var user = UserModel.fromJson(userMap);
    summaryMap["employee"] = user;
  }

  var summary = SummaryModel.fromJson(summaryMap);
  return summary;
}
