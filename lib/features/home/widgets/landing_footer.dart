import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/strings.dart';
import '../../../core/widgets/app_logo.dart';

class LandingFooter extends StatelessWidget {
  const LandingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppBreakpoints.mobile;

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.desktop),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.xxxl,
            ),
            child: Column(
              children: [
                isMobile
                    ? Column(
                        children: [
                          _FooterLogo(),
                          const SizedBox(height: 24),
                          _FooterLinks(),
                          const SizedBox(height: 16),
                          _FooterContact(),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _FooterLogo(),
                          _FooterLinks(),
                          _FooterContact(),
                        ],
                      ),
                const SizedBox(height: 32),
                Text(
                  AppStrings.copyright,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textHint.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppLogo(size: 36, showText: true, withShadow: false);
  }
}

class _FooterLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: ['Privacy', 'Terms', 'Contact'].map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            item,
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _FooterContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.email,
      style: AppTypography.bodySmall.copyWith(
        color: AppColors.textHint,
      ),
    );
  }
}
