import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LanguageService with ChangeNotifier {
  void changeLanguage(String lang) async {
    var box = Hive.box('language');
    box.put("current", lang);
  }
}
