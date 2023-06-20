import 'package:adret/client.dart';
import 'package:adret/graphql/user.dart';
import 'package:adret/model/user/index.dart';
import 'package:adret/utils/convert/user_convertor.dart';
import 'package:adret/utils/error/api.dart';
import 'package:graphql/client.dart';

Future<UserModel?> createUserFunction({
  required String fullName,
  required String password,
  required String phoneNumber,
  required String userName,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().mutate(
      MutationOptions(document: gql(UserGraphql.createUser), variables: {
        "input": {
          "fullName": fullName,
          "password": password,
          "phoneNumber": phoneNumber,
          "userName": userName
        }
      }),
    );

    if (result.exception != null) {
      var msg = "Error creating Employee. Please Try Again";

      if (result.exception != null &&
          result.exception?.graphqlErrors != null &&
          result.exception!.graphqlErrors.isNotEmpty &&
          result.exception?.graphqlErrors[0].message ==
              "UsernameExistsException: User account already exists") {
        msg =
            "The given Username is already taken, please change it and try again!";
      } else if (result.exception != null &&
          result.exception?.graphqlErrors != null &&
          result.exception!.graphqlErrors.isNotEmpty &&
          result.exception!.graphqlErrors[0].message
              .contains("UniqueConstraintViolation") &&
          result.exception!.graphqlErrors[0].message.contains("phoneNumber")) {
        msg =
            "The given PhoneNumber is already taken, please change it and try again!";
      } else if (result.exception != null &&
          result.exception?.graphqlErrors != null &&
          result.exception!.graphqlErrors.isNotEmpty &&
          result.exception!.graphqlErrors[0].message ==
              "a company can have max 3 employees at the moment") {
        msg = "You have reach the max amount of employee your shop can add.";
      }

      throw ApiException(msg);
    } else if (result.data != null) {
      UserModel user = userConverter(data: result.data!["createUser"]);
      return user;
    }
    return null;
  } catch (e) {
    throw Exception(e);
  }
}
