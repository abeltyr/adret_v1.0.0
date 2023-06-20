// ignore: file_names
import 'package:adret/model/company/index.dart';
import 'package:adret/model/user/index.dart';

CompanyModel companyConverter({
  required dynamic data,
}) {
  Map<String, dynamic> companyMap = Map<String, dynamic>.from(data);

  if (companyMap["owner"] != null) {
    Map<String, dynamic> userMap =
        Map<String, dynamic>.from(companyMap["owner"]);
    var owner = UserModel.fromJson(userMap);

    companyMap["owner"] = owner;
  }

  var inventory = CompanyModel.fromJson(companyMap);

  return inventory;
}
