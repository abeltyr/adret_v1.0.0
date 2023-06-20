import 'package:adret/model/shared.dart';
import 'package:adret/model/user/index.dart';
import 'package:adret/model/userSettings/index.dart';
import 'package:adret/services/user/actions/fetch_users.dart';
import 'package:adret/services/user/actions/login.dart';
import 'package:adret/services/user/actions/fetch_user.dart';
import 'package:adret/services/user/actions/update_user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserService with ChangeNotifier {
  var hiveUser = Hive.box<UserModel>('user');
  var hiveUserRole = Hive.box('userRole');
  var hiveUserSetting = Hive.box<UserSettingModel>('userSetting');

  UserModel get currentUser =>
      hiveUser.get("current", defaultValue: UserModel())!;

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  bool _loading = false;
  bool get loading => _loading;
  void updateLoading(bool value) {
    _loading = value;
  }

  Future<void> login({
    required String userName,
    required String companyId,
    required String password,
  }) async {
    try {
      await loginFunction(
          userName: userName, companyId: companyId, password: password);
      await fetchUserFunction();
    } catch (e) {
      // logout();
      throw Exception(e);
    }
  }

  Future<void> fetchUser() async {
    try {
      await fetchUserFunction();
    } catch (e) {
      // logout();
    }
  }

  Future<void> logout() async {
    hiveUser.put("current", UserModel());
    hiveUserRole.put("current", null);
    hiveUserSetting.put("current", UserSettingModel());
    var navbarBox = Hive.box('navbar');
    navbarBox.put("current", 0);
  }

  Future<bool> loadMoreUsers() async {
    String? userAfter;
    if (_users.isNotEmpty) {
      userAfter = users[users.length - 1].id;
    }
    int fetchSize = 30;
    try {
      List<UserModel> loadedUsers = await fetchUsersFunction(
        filter: FilterModel(
          limit: fetchSize,
          after: userAfter,
        ),
        exceptMe: true,
      );
      _users = [..._users, ...loadedUsers];

      notifyListeners();

      if (loadedUsers.length < fetchSize) {
        return false;
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> refreshUsers() async {
    if (!_loading) {
      if (users.isEmpty) _loading = true;
      String? userBefore;
      if (users.isNotEmpty) {
        userBefore = users[0].id;
      }
      try {
        List<UserModel> newUsers = await fetchUsersFunction(
          filter: FilterModel(
            limit: 30,
            before: userBefore,
          ),
          exceptMe: true,
        );

        _users = [...newUsers, ..._users];
      } catch (e) {
        throw Exception(e);
      }
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser({
    required String fullName,
    required String email,
    required String phoneNumber,
  }) async {
    if (currentUser.id != null) {
      var updateUser = await updateUserFunction(
        id: currentUser.id!,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
      );

      if (updateUser != null) {
        var hiveUser = Hive.box<UserModel>('user');
        hiveUser.put("current", updateUser);
        notifyListeners();
      }
    }
  }

  Future<void> addUser(UserModel user) async {
    _users = [user, ..._users];
    notifyListeners();
  }

  Future<void> updateUserList(
      {required UserModel user, required int index}) async {
    _users[index] = user;
    notifyListeners();
  }
}
