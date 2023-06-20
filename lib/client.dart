import 'package:adret/model/user/index.dart';
import 'package:adret/model/userSettings/index.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql/client.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Config {
  static final headers = {
    "Content-Type": "application/json",
  };
  static final _httpLink = HttpLink(
    dotenv.get("BACKEND_API"),
    defaultHeaders: headers,
  );

  static final AuthLink _authLink = AuthLink(
    headerKey: "Authorization",
    getToken: () async {
      var hiveUserSetting = Hive.box<UserSettingModel>('userSetting');
      bool foundError = false;
      UserSettingModel userSetting =
          hiveUserSetting.get("current", defaultValue: UserSettingModel())!;
      var accessTokenString = userSetting.accessToken;
      if (accessTokenString != null) {
        Map<String, dynamic> payload = Jwt.parseJwt(accessTokenString);
        if (payload.isNotEmpty) {
          var now = DateTime.now().millisecondsSinceEpoch / 1000;
          var idTokenString = userSetting.idToken;
          var refreshTokenString = userSetting.refreshToken;
          var userName = userSetting.userName;
          if (now >= payload["exp"]) {
            var idToken = CognitoIdToken(idTokenString);
            var accessToken = CognitoAccessToken(accessTokenString);
            var refreshToken = CognitoRefreshToken(refreshTokenString);

            final session = CognitoUserSession(
              idToken,
              accessToken,
              refreshToken: refreshToken,
            );

            final userPool = CognitoUserPool(
              dotenv.get("AWS_USER_POOL"),
              dotenv.get("AWS_COGNITO_CLIENT_ID"),
            );

            final cognitoUser = CognitoUser(
              userName,
              userPool,
              signInUserSession: session,
            );
            try {
              var newUser = await cognitoUser.refreshSession(refreshToken);
              var newRefreshToken = newUser!.getRefreshToken()!.getToken();
              var newAccessToken = newUser.accessToken.jwtToken;
              var newIdToken = newUser.idToken.jwtToken;
              userSetting.accessToken = newAccessToken;
              userSetting.refreshToken = newRefreshToken;
              userSetting.idToken = newIdToken;

              hiveUserSetting.put("current", userSetting);
              accessTokenString == newAccessToken;
            } catch (e) {
              var hiveUser = Hive.box<UserModel>('user');
              hiveUser.put("current", UserModel());
              var hiveUserRole = Hive.box('userRole');
              hiveUserRole.put("current", null);
              hiveUserSetting.put("current", UserSettingModel());
              var navbarBox = Hive.box('navbar');
              navbarBox.put("current", 0);
              foundError = true;
            }
          }
        }
        if (!foundError) return accessTokenString;
      }
      return null;
    },
  );

  static final Link _link = _authLink.concat(_httpLink);

  static GraphQLClient initializeClient() {
    final policies = Policies(
      fetch: FetchPolicy.networkOnly,
    );
    // final store = await HiveStore.open(path: 'my/cache/path');
    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
      defaultPolicies: DefaultPolicies(
        watchQuery: policies,
        query: policies,
        mutate: policies,
      ),
    );

    return client;
  }
}
