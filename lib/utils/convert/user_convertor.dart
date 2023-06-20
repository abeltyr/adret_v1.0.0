import 'package:adret/model/user/index.dart';
import 'package:adret/utils/convert/company_convertor.dart';

UserModel userConverter({
  required dynamic data,
}) {
  Map<String, dynamic> userMap = Map<String, dynamic>.from(data);

  if (userMap["company"] != null) {
    var company = companyConverter(data: userMap["company"]);

    userMap["company"] = company;
  }

  var user = UserModel.fromJson(userMap);

  return user;
}
