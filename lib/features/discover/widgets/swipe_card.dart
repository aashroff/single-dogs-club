import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../models/dog_profile.dart';

class SwipeCard extends StatelessWidget {
  final DogProfile profile;

  const SwipeCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: AppColors.borderCoral.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Photo area
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.sand,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.xxl),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('\uD83D\uDC36', style: TextStyle(fontSize: 80)),
                    const SizedBox(height: 8),
                    Text(
                      'Photo of ${profile.name}',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Info area
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          profile.name,
                          style: AppTypography.headlineLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.sage.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${profile.ageYears} yrs',
                          style: AppTypography.tag,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.breed,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  const Spacer(),
                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _CardTag(
                        label: profile.temperamentLabel,
                        bgColor: AppColors.sage.withOpacity(0.15),
                        textColor: AppColors.sageDark,
                      ),
                      _CardTag(
                        label: '${profile.activityLabel} energy',
                        bgColor: AppColors.coral.withOpacity(0.12),
                        textColor: AppColors.coralDark,
                      ),
                      _CardTag(
                        label: profile.sizeLabel,
                        bgColor: AppColors.sand,
                        textColor: AppColors.textSecondary,
                      ),
                    ],
                  ),
                  if (profile.bio != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      profile.bio!,
                      style: AppTypography.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardTag extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;

  const _CardTag({
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTypography.tag.copyWith(color: textColor),
      ),
    );
  }
}
