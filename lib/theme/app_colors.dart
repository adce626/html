import 'package:flutter/material.dart';

/// SAMA App Color Palette
/// Single source of truth for all brand colors.
class AppColors {
  AppColors._();

  // ─── Primary Brand ─────────────────────────────────
  static const Color primary = Color(0xFFC21E2C);
  static const Color primaryDark = Color(0xFF8F1620);
  static const Color primaryLight = Color(0xFFF5D5D8);
  static const Color primaryDeep = Color(0xFF8B0000);
  static const Color primaryDarkest = Color(0xFF5C0000);

  // ─── WhatsApp ──────────────────────────────────────
  static const Color whatsapp = Color(0xFF25D366);

  // ─── Service Accent Colors ─────────────────────────
  static const Color infoBlue = Color(0xFF3B82F6);
  static const Color infoPurple = Color(0xFF8B5CF6);
  static const Color infoAmber = Color(0xFFF59E0B);
  static const Color infoGreen = Color(0xFF22C55E);

  // ─── Light Mode ────────────────────────────────────
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F7F5);
  static const Color surfaceAlt = Color(0xFFF5F3F1);
  static const Color textPrimary = Color(0xFF141414);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFF999999);
  static const Color border = Color(0xFFE5E2DC);
  static const Color borderLight = Color(0xFFF3F4F6);

  // ─── Dark Mode ─────────────────────────────────────
  static const Color darkBg = Color(0xFF141414);
  static const Color darkSurface = Color(0xFF1C1C1A);
  static const Color darkSurfaceAlt = Color(0xFF252523);
  static const Color darkTextPrimary = Color(0xFFF5F3F1);
  static const Color darkTextSecondary = Color(0xFFC4BFB6);
  static const Color darkTextMuted = Color(0xFF8A8580);
  static const Color darkBorder = Color(0xFF2D2D2B);

  // ─── Status ────────────────────────────────────────
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFDC2626);
}
