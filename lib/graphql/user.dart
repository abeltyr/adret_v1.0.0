class UserGraphql {
  static String currentUser = r'''
    query CurrentUser {
      currentUser {
        id
        fullName
        phoneNumber
        email
        userName
        isActive
        userRole
        company {
          companyCode
          id
          name
          detail
          ownerId
        }
      }
    }
  ''';

  static String users = r'''
    query Users($input: usersFilter!) {
      users(input: $input) {
          id
          fullName
          phoneNumber
          email
          userName
          isActive
          userRole
      }
    }
  ''';

  static String createUser = r'''
    mutation CreateUser($input: createUserInput!) {
      createUser(input: $input) {
        id
        fullName
        phoneNumber
        email
        userName
        isActive
        userRole
      }
    }
  ''';

  static String updateUser = r'''
    mutation UpdateUser($input: updateUserInput!) {
      updateUser(input: $input) {
        id
        fullName
        phoneNumber
        email
        userName
        isActive
        userRole
        company {
          companyCode
          id
          name
          detail
          ownerId
        }
      }
    }
  ''';

  static String updateUserPassword = r'''
    mutation UpdateUserPassword($input: updateUserPasswordInput!) {
      updateUserPassword(input: $input)
    }
  ''';

  static String updatePersonalPassword = r'''
    mutation UpdatePersonalPassword($input: updatePersonalPasswordInput!) {
      updatePersonalPassword(input: $input)
    }
  ''';
}
