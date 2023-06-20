import 'package:adret/model/userSettings/index.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';

final userPool = CognitoUserPool(
  dotenv.get("AWS_USER_POOL"),
  dotenv.get("AWS_COGNITO_CLIENT_ID"),
);

Future<void> loginFunction({
  required String userName,
  required String companyId,
  required String password,
}) async {
  final cognitoUser = CognitoUser('$companyId-$userName', userPool);
  final authDetails = AuthenticationDetails(
    username: '$companyId-$userName',
    password: password,
  );

  try {
    var session = await cognitoUser.authenticateUser(authDetails);
    if (session != null) {
      var refreshToken = session.getRefreshToken()!.getToken();
      var accessToken = session.accessToken.jwtToken;
      var idToken = session.idToken.jwtToken;

      var hiveUserSetting = Hive.box<UserSettingModel>('userSetting');

      UserSettingModel userSetting =
          hiveUserSetting.get("current", defaultValue: UserSettingModel())!;
      userSetting.accessToken = accessToken;
      userSetting.refreshToken = refreshToken;
      userSetting.idToken = idToken;
      userSetting.companyId = companyId;
      userSetting.userName = '$companyId-$userName';

      hiveUserSetting.put("current", userSetting);
    }
  } catch (e) {
    throw Exception(e);
  }
}
