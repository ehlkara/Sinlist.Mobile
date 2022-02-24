import 'package:flutter/material.dart';

class Theme {
  static const MaterialColor orange = MaterialColor(
    _orangePrimaryValue,
    <int, Color>{
      50: Color(0xffea6227),
      100: Color(0xffea6227),
      200: Color(0xffea6227),
      300: Color(0xffea6227),
      400: Color(0xffea6227),
      500: Color(_orangePrimaryValue),
      600: Color(0xffea6227),
      700: Color(0xffea6227),
      800: Color(0xffea6227),
      900: Color(0xffea6227),
    },
  );
  static const int _orangePrimaryValue = 0xffea6227;
}
