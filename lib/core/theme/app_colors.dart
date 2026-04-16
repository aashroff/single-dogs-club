import 'package:flutter/material.dart';

/// Single Dogs' Club brand colour palette.
/// Derived from the original Canva design PDF.
class AppColors {
  AppColors._();

  // ── Primary: Coral / Salmon ──
  static const Color coral = Color(0xFFE8837C);
  static const Color coralDark = Color(0xFFD4655F);
  static const Color coralLight = Color(0xFFF2ADA8);
  static const Color coralPale = Color(0xFFFCE8E6);

  // ── Secondary: Sage / Green ──
  static const Color sage = Color(0xFF7AB68E);
  static const Color sageDark = Color(0xFF5A9E6E);
  static const Color sageLight = Color(0xFFA8D4B8);
  static const Color sagePale = Color(0xFFE8F5E9);

  // ── Neutrals: Warm Cream / Forest ──
  static const Color cream = Color(0xFFFDF8F4);
  static const Color creamDark = Color(0xFFFDF6F0);
  static const Color sand = Color(0xFFF5EDE4);
  static const Color forest = Color(0xFF2D3A2E);
  static const Color forestLight = Color(0xFF3A4D3C);
  static const Color textPrimary = Color(0xFF2D3A2E);
  static const Color textSecondary = Color(0xFF6B7C6D);
  static const Color textMuted = Color(0xFF8A9B8C);
  static const Color textHint = Color(0xFFA0B0A2);

  // ── Surfaces ──
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDim = Color(0xFFF0F7F1);
  static const Color border = Color(0x0A000000);
  static const Color borderCoral = Color(0x1FE8837C);

  // ── Feedback ──
  static const Color success = Color(0xFF5A9E6E);
  static const Color warning = Color(0xFFF0A830);
  static const Color error = Color(0xFFD4655F);

  // ── Gradients ──
  static const LinearGradient coralGradient = LinearGradient(
    colors: [coral, coralDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sageGradient = LinearGradient(
    colors: [sage, sageDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient forestGradient = LinearGradient(
    colors: [forest, forestLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
