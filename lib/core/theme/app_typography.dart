import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography system for Single Dogs' Club.
///
/// Display / headings: Fraunces (serif, warm, distinctive)
/// Body / UI: DM Sans (clean, modern, highly legible)
class AppTypography {
  AppTypography._();

  // ── Display / Headlines (Fraunces) ──

  static TextStyle displayLarge = GoogleFonts.fraunces(
    fontSize: 56,
    fontWeight: FontWeight.w700,
    height: 1.1,
    color: AppColors.textPrimary,
  );

  static TextStyle displayMedium = GoogleFonts.fraunces(
    fontSize: 44,
    fontWeight: FontWeight.w700,
    height: 1.15,
    color: AppColors.textPrimary,
  );

  static TextStyle displaySmall = GoogleFonts.fraunces(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineLarge = GoogleFonts.fraunces(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineMedium = GoogleFonts.fraunces(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineSmall = GoogleFonts.fraunces(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  // ── Body / UI (DM Sans) ──

  static TextStyle bodyLarge = GoogleFonts.dmSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.7,
    color: AppColors.textSecondary,
  );

  static TextStyle bodyMedium = GoogleFonts.dmSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.65,
    color: AppColors.textSecondary,
  );

  static TextStyle bodySmall = GoogleFonts.dmSans(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textMuted,
  );

  // ── Labels & Buttons ──

  static TextStyle labelLarge = GoogleFonts.dmSans(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    height: 1.0,
    color: AppColors.surface,
  );

  static TextStyle labelMedium = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.0,
    color: AppColors.textPrimary,
  );

  static TextStyle labelSmall = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0.8,
    color: AppColors.textMuted,
  );

  // ── Overline / Tags ──

  static TextStyle overline = GoogleFonts.dmSans(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 1.2,
    color: AppColors.sage,
  );

  static TextStyle tag = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.0,
    color: AppColors.sageDark,
  );
}
