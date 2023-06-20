import 'package:adret/client.dart';
import 'package:adret/graphql/user.dart';
import 'package:adret/model/user/index.dart';
import 'package:adret/utils/convert/user_convertor.dart';
import 'package:adret/utils/error/api.dart';
import 'package:graphql/client.dart';

Future<UserModel?> updateUserFunction({
  required String email,
  required String fullName,
  required String phoneNumber,
  required String id,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().mutate(
      MutationOptions(document: gql(UserGraphql.updateUser), variables: {
        "input": {
          "id": id,
          "email": email,
          "fullName": fullName,
          "phoneNumber": phoneNumber
        }
      }),
    );

    if (result.exception != null) {
      var msg = "Error updating Profile. Please Try Again";
      // if (result.exception != null &&
      // result.exception?.graphqlErrors != null &&
      // result.exception!.graphqlErrors.isNotEmpty ) {
      //   msg = result.exception?.graphqlErrors[0].message ?? msg;
      // }
      throw ApiException(msg);
    } else if (result.data != null) {
      UserModel user = userConverter(data: result.data!["updateUser"]);
      return user;
    }
    return null;
  } catch (e) {
    throw Exception(e);
  }
}
