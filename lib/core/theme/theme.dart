import 'package:flutter/material.dart';
import 'package:task_list/core/colors/AppColors.dart';

ThemeData theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Appcolors.teal,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: Colors.grey[50],
  cardColor: Colors.white,
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      color: Colors.black87,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      color: Colors.grey,
    )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Appcolors.teal,
    unselectedItemColor: Colors.grey,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Appcolors.teal,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return Appcolors.teal;
      }
      return Colors.transparent;
    }),
    side: BorderSide(color: Appcolors.teal),
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF1A1A1A),
  colorScheme: ColorScheme.dark(
    primary: Colors.blue,
    secondary: Colors.blueAccent,
    surface: const Color(0xFF2C2C2C),
    background: const Color(0xFF1A1A1A),
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
  ),
  cardColor: const Color(0xFF1E1E1E),
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      color: Colors.grey,
    )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF2C2C2C),
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(color: Colors.blue),
    unselectedIconTheme: IconThemeData(color: Colors.grey),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return Appcolors.teal;
      }
      return Colors.transparent;
    }),
    side: const BorderSide(color: Appcolors.teal),
  ),
);
