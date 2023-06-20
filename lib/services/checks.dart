import 'dart:io';
import 'package:flutter/material.dart';

class CheckService with ChangeNotifier {
  bool _loadingScreen = false;
  bool _loadingButton = false;
  bool _connectionIssue = false;

  bool get loadingScreen => _loadingScreen;
  bool get connectionIssue => _connectionIssue;
  bool get loadingButton => _loadingButton;

  updateLoadingScreen(bool data) {
    _loadingScreen = data;
    notifyListeners();
  }

  updateLoadingButton(bool data) {
    _loadingButton = data;
    notifyListeners();
  }

  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('api.adr.et');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _connectionIssue = false;
      }
    } on SocketException catch (_) {
      _connectionIssue = true;
    }

    notifyListeners();
  }
}
