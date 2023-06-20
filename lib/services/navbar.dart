// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NavbarService with ChangeNotifier {
  var navbarBox = Hive.box('navbar');

  int get navBarIndex => navbarBox.get("current", defaultValue: 0);

  void updateNavBarIndex(int index) async {
    navbarBox.put("current", index);
    notifyListeners();
  }

  Future<bool> checkConnection() async {
    bool connected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connected = true;
      }
    } on SocketException catch (_) {
      connected = false;
    }
    return connected;
  }
}
