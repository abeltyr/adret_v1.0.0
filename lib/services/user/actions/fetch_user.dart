import 'package:adret/client.dart';
import 'package:adret/graphql/user.dart';
import 'package:adret/model/user/index.dart';
import 'package:adret/model/userSettings/index.dart';
import 'package:adret/utils/convert/user_convertor.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';

Future<void> fetchUserFunction() async {
  try {
    var hiveUser = Hive.box<UserModel>('user');
    var hiveUserRole = Hive.box('userRole');

    var hiveUserSetting = Hive.box<UserSettingModel>('userSetting');

    UserSettingModel userSetting =
        hiveUserSetting.get("current", defaultValue: UserSettingModel())!;
    var fetchTime = userSetting.fetchTime;

    if (fetchTime != null &&
        DateTime.now().millisecondsSinceEpoch - fetchTime < 120000) {
      return;
    }

    final QueryResult result = await Config.initializeClient().query(
      QueryOptions(
        document: gql(UserGraphql.currentUser),
      ),
    );

    if (result.exception != null) {
      throw Exception(result.exception);
    } else if (result.data != null) {
      UserModel user = userConverter(data: result.data!["currentUser"]);
      userSetting.fetchTime = DateTime.now().millisecondsSinceEpoch;

      hiveUserRole.put("current", user.userRole);
      hiveUser.put("current", user);
      hiveUserSetting.put("current", userSetting);
    }
  } catch (e) {
    throw Exception(e);
  }
}
