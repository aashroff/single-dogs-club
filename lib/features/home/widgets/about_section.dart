import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/app_logo.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.forest, AppColors.forestLight],
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sectionLarge,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'OUR STORY',
                style: AppTypography.overline.copyWith(color: AppColors.sage),
              ),
              const SizedBox(height: 16),
              Text(
                'Everyone, Meet Petra!',
                style: AppTypography.displaySmall.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const AppLogo(size: 72, withShadow: false),
              const SizedBox(height: 24),
              Text(
                'Petra is a failed Guide Dog (don\'t feel sorry for her, '
                'she lives the life of Riley!). Her human Sarah adopted '
                'her in 2025, and it was clear Petra needed some canine '
                'entertainment. And so, the Single Dogs\' Club was born.',
                style: AppTypography.bodyLarge.copyWith(
                  color: Colors.white.withOpacity(0.75),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Our mission is to improve canine welfare by increasing '
                'positive social interactions for dogs AND their humans. '
                'We know how lonely life can be sometimes, and we\'d like '
                'to do our bit by connecting more people.',
                style: AppTypography.bodyLarge.copyWith(
                  color: Colors.white.withOpacity(0.75),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Team cards
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _TeamMember(
                      name: 'Sarah',
                      role: 'Ex-RSPCA Inspector\nAnimal Behaviour & Welfare',
                      color: AppColors.sage,
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      color: Colors.white.withOpacity(0.15),
                    ),
                    _TeamMember(
                      name: 'Ash',
                      role: 'IT Guru\nPipeline & App Development',
                      color: AppColors.coral,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamMember extends StatelessWidget {
  final String name;
  final String role;
  final Color color;

  const _TeamMember({
    required this.name,
    required this.role,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: AppTypography.labelMedium.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          role,
          style: AppTypography.bodySmall.copyWith(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
