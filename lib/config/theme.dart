import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

export '../theme/app_colors.dart';

class AppTheme {
  static ThemeData _base(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBg : AppColors.background;
    final tp = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final ts = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final sf = isDark ? AppColors.darkSurface : AppColors.surface;
    final bd = isDark ? AppColors.darkBorder : AppColors.border;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: bg,
      fontFamily: 'Cairo',
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.primary,
        surface: sf,
        onPrimary: Colors.white,
        onSurface: tp,
        secondary: AppColors.primary,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        foregroundColor: tp,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(fontFamily: 'Cairo', fontSize: 17, fontWeight: FontWeight.w800, color: tp),
      ),
      cardTheme: CardThemeData(
        color: sf,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide(color: bd, width: 1)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: sf,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.primary, width: 1.5)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.error, width: 1)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: TextStyle(fontFamily: 'Cairo', color: ts, fontWeight: FontWeight.w600, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          textStyle: TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: tp,
        contentTextStyle: TextStyle(fontFamily: 'Cairo', color: isDark ? AppColors.darkBg : Colors.white, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData light() => _base(Brightness.light);
  static ThemeData dark() => _base(Brightness.dark);
}
