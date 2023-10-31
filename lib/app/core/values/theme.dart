import 'package:flutter/material.dart';
import 'package:money_keeper/app/core/values/color.dart';
import 'package:money_keeper/app/core/values/style.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    textTheme: ThemeData.light().textTheme.apply(fontFamily: "Poppins"),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xffF7FAFC),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        textStyle: AppStyles.text14Normal.copyWith(
          fontWeight: FontWeight.bold,
        ),
        padding: EdgeInsets.zero,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: AppColors.hintColor,
      selectedItemColor: AppColors.primaryColor,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black,
      contentPadding: EdgeInsets.zero,
      dense: true,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      titleSpacing: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.transparent,
      filled: true,
      suffixIconColor: AppColors.hintColor,
      hintStyle: AppStyles.text16Normal.copyWith(
        color: AppColors.hintColor,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: .5,
          color: AppColors.hintColor,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: .5,
          color: AppColors.primaryColor,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        textStyle: AppStyles.text16Bold.copyWith(
          color: Colors.white,
        ),
      ),
    ),

    ///
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: Colors.black,
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: "Poppins"),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.dark,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color(0xff303030),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0xff303030), filled: true, suffixIconColor: Colors.white),
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.primaryColor,
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
