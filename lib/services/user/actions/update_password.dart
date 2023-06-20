import 'package:adret/client.dart';
import 'package:adret/graphql/user.dart';
import 'package:graphql/client.dart';

Future<dynamic> updatePasswordFunction({
  required String password,
  required String username,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().mutate(
      MutationOptions(
          document: gql(UserGraphql.updateUserPassword),
          variables: {
            "input": {"password": password, "username": username}
          }),
    );

    if (result.hasException) {
      throw Exception(result.exception!.graphqlErrors[0].message);
    } else if (result.data != null) {
      return result.data!["updateUserPassword"];
    }
  } catch (e) {
    throw Exception(e);
  }
}
