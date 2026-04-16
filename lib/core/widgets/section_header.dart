import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class SectionHeader extends StatelessWidget {
  final String? overline;
  final String title;
  final String? subtitle;
  final Color? overlineColor;

  const SectionHeader({
    super.key,
    this.overline,
    required this.title,
    this.subtitle,
    this.overlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (overline != null) ...[
          Text(
            overline!.toUpperCase(),
            style: AppTypography.overline.copyWith(
              color: overlineColor ?? AppColors.sage,
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(
          title,
          style: AppTypography.displaySmall,
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              subtitle!,
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }
}
