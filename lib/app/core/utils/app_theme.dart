import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';
import 'package:metal_forte/app/core/utils/app_css.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
      fontFamily: 'WorkSans',
      colorSchemeSeed: AppColors.primaryMain,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: const Color(0xFFBFD0D0),
        selectionColor: const Color(0xFFBFD0D0).withOpacity(0.3),
        selectionHandleColor: const Color(0xFFBFD0D0),
      ),
      datePickerTheme: DatePickerThemeData(
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryMain;
          }
          return null;
        }),
        backgroundColor: AppColors.neutralMedium,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) =>
                states.contains(WidgetState.disabled)
                    ? AppColors.neutralMedium
                    : AppColors.primaryMain),
            textStyle: WidgetStatePropertyAll(
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
                    .setColor(AppColors.neutralLightest)),
            foregroundColor: WidgetStatePropertyAll(AppColors.white),
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: AppCss.radius8))),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            AppColors.primaryMain,
          ),
          foregroundColor: WidgetStatePropertyAll(AppColors.white),
          iconSize: const WidgetStatePropertyAll(24),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: AppCss.radius8)),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.neutralMedium, width: 1),
            borderRadius: AppCss.radius8,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryMain, width: 2),
            borderRadius: AppCss.radius8,
          ),
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.neutralMedium)),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryMain,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: AppColors.primaryMain,
          shadowColor: Colors.transparent),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 10,
        backgroundColor: AppColors.primaryMain,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white,
        selectedLabelStyle: TextStyle(
            color: AppColors.white, fontWeight: FontWeight.w500, fontSize: 16),
        unselectedLabelStyle: TextStyle(color: Colors.grey[100]),
      ));
}
