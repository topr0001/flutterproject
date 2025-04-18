import 'package:flutter/material.dart';

final TextTheme textTheme = TextTheme(
  titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
  titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
  titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
  bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
  bodySmall: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w400),
);

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.deepPurple.shade400,
    onPrimary: Color(0xFF121212),
    secondary: Colors.grey.shade100,
    onSecondary: Color(0xFF121212),
    error: Colors.red.shade400,
    onError: Color(0xFF121212),
    surface: Color(0xFFFAFAFA),
    onSurface: Color(0xFF121212),
  ),
  textTheme: textTheme,
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.deepPurple.shade800,
    onPrimary: Color(0xFFFAFAFA),
    secondary: Colors.grey.shade900,
    onSecondary: Color(0xFFFAFAFA),
    error: Colors.red.shade500,
    onError: Color(0xFFFAFAFA),
    surface: Color(0xFF121212),
    onSurface: Color(0xFFFAFAFA),
  ),
  textTheme: textTheme,
);
