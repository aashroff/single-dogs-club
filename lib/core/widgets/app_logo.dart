import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Brand logo widget used across the app.
/// Renders the circular Single Dogs' Club logo at the given [size].
class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool withShadow;

  const AppLogo({
    super.key,
    this.size = 42,
    this.showText = false,
    this.withShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    // Use pre-downscaled asset to avoid browser aliasing artifacts.
    // logo_sm.png = 128px, logo.png = 256px
    final asset = size <= 64
        ? 'assets/images/logo_sm.png'
        : 'assets/images/logo.png';

    final logoImage = Container(
      width: size,
      height: size,
      decoration: withShadow
          ? BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.coral.withOpacity(0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            )
          : null,
      child: Image.asset(
        asset,
        width: size,
        height: size,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        isAntiAlias: true,
      ),
    );

    if (!showText) return logoImage;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        logoImage,
        const SizedBox(width: 10),
        Text(
          'Single Dogs\' Club',
          style: AppTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
