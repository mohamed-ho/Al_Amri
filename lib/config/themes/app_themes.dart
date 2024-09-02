import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  static appTheme() {
    return ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: AppColors.secondColor,
            sizeConstraints: BoxConstraints(minHeight: 130.r, minWidth: 130.r),
            foregroundColor: Colors.white,
            hoverColor: AppColors.thirdColor),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(AppColors.primaryColor),
          ),
        ),
        textTheme: TextTheme(
          labelSmall: TextStyle(
              fontSize: 16.spMax,
              fontWeight: FontWeight.bold,
              color: Colors.white),
          titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 16.spMax,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.clip),
          titleSmall: TextStyle(
            color: Colors.white,
            fontSize: 12.spMax,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 14.spMax,
          ),
        ));
  }
}
