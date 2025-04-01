import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.lightBlue,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.lightBlue,
    brightness: Brightness.dark,
  ),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.lightBlue,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.lightBlue,
    brightness: Brightness.light,
  ),
);
