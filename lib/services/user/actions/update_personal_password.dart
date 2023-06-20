import 'package:adret/client.dart';
import 'package:adret/graphql/user.dart';
import 'package:adret/utils/error/api.dart';
import 'package:graphql/client.dart';

Future<bool> updatePersonalPasswordFunction({
  required String oldPassword,
  required String password,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().mutate(
      MutationOptions(
          document: gql(UserGraphql.updatePersonalPassword),
          variables: {
            "input": {
              "oldPassword": oldPassword,
              "password": password,
            }
          }),
    );

    if (result.exception != null) {
      var msg = "Error updating password. Please Try Again";
      // if (result.exception != null &&
      // result.exception?.graphqlErrors != null &&
      // result.exception!.graphqlErrors.isNotEmpty &&) {
      //   msg = result.exception?.graphqlErrors[0].message ?? msg;
      // }
      throw ApiException(msg);
    } else if (result.data != null) {
      return result.data!["updatePersonalPassword"];
    }
  } catch (e) {
    throw Exception(e);
  }
  return false;
}
