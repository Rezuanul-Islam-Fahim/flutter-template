import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color primaryColor = const Color(0xfff66b50);

  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.grey[100],
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            titleSmall: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            titleMedium: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            titleLarge: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            displayMedium: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            displayLarge: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
