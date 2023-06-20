import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';

class InputTheme {
  InputDecoration textDecoration({required String label}) {
    return InputDecoration(
      fillColor: DarkModePlatformTheme.positive,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: label,
      contentPadding: const EdgeInsets.fromLTRB(0.0, -15, 10.0, 0),
      labelStyle: const TextStyle(
        fontFamily: 'Nunito',
        color: DarkModePlatformTheme.primaryLight2,
        fontWeight: FontWeight.w600,
        fontSize: 20,
        wordSpacing: 0.1,
      ),
    );
  }

  InputDecoration textInputDecoration(
      {required String label, double size = 16}) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: DarkModePlatformTheme.white,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: DarkModePlatformTheme.negative,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: DarkModePlatformTheme.white,
        ),
      ),
      labelStyle: TextStyle(
        fontFamily: 'Nunito',
        color: DarkModePlatformTheme.primaryLight2,
        fontWeight: FontWeight.w600,
        fontSize: size,
        wordSpacing: 1,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: DarkModePlatformTheme.negative,
        ),
      ),
      focusColor: DarkModePlatformTheme.white,
      labelText: label,
      contentPadding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
    );
  }

  InputDecoration textAreaDecoration({required String label}) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: DarkModePlatformTheme.white,
        ),
      ),
      labelStyle: const TextStyle(
        fontFamily: 'Nunito',
        color: DarkModePlatformTheme.white,
        fontWeight: FontWeight.w700,
        fontSize: 22.5,
        wordSpacing: 1,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: DarkModePlatformTheme.white,
        ),
      ),
      labelText: label,
      contentPadding: const EdgeInsets.fromLTRB(15.0, 15, 15, 15),
    );
  }
}
