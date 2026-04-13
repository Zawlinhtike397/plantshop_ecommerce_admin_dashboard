import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/themes/custom_themes/app_elevated_button_theme.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/themes/custom_themes/app_text_field_theme.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/themes/custom_themes/app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColor.primaryBackground,
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    textTheme: AppTextTheme.lightTextTheme,
    inputDecorationTheme: AppTextFieldTheme.lightInputDecorTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColor.darkBackground,
    brightness: Brightness.dark,
    primaryColor: AppColor.primary,
    textTheme: AppTextTheme.darkTextTheme,
    inputDecorationTheme: AppTextFieldTheme.darkInputDecorTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
  );
}
