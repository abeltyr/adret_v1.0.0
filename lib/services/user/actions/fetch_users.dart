import 'package:adret/client.dart';
import 'package:adret/graphql/user.dart';
import 'package:adret/model/shared.dart';
import 'package:adret/model/user/index.dart';
import 'package:adret/utils/convert/user_convertor.dart';
import 'package:graphql/client.dart';

Future<dynamic> fetchUsersFunction({
  FilterModel? filter,
  String? role,
  exceptMe = true,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().query(
      QueryOptions(
        document: gql(UserGraphql.users),
        variables: {
          "input": {
            "role": null,
            "filter": filter!.toMap(),
            "exceptMe": exceptMe
          }
        },
      ),
    );

    if (result.exception != null) {
      throw Exception(result.exception);
    } else if (result.data != null) {
      List<UserModel> users = [];
      for (var data in result.data!["users"]) {
        UserModel user = userConverter(
          data: data,
        );
        users.add(user);
      }

      return users;
    }
  } catch (e) {
    throw Exception(e);
  }
}
