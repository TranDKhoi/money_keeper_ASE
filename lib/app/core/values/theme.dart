import 'package:flutter/material.dart';

class AppColors {
  static final lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: "Roboto",
        ),
    colorScheme: const ColorScheme.light(primary: Colors.green),
    appBarTheme: AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.grey[50],
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.grey[50],
        filled: true,
        suffixIconColor: Colors.black),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.green,
      unselectedLabelColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[50],
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: "Roboto",
        ),
    colorScheme: const ColorScheme.light(primary: Colors.green),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color(0xff303030),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0xff303030),
        filled: true,
        suffixIconColor: Colors.white),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.green,
      unselectedLabelColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff303030),
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.white,
    ),
  );
}
