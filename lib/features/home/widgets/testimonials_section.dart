import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/section_header.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  static const _testimonials = [
    (
      text: 'Luna found her best friend through Single Dogs\' Club! '
          'We now walk together every weekend.',
      owner: 'Rebecca & Luna',
      location: 'Leeds',
    ),
    (
      text: 'As a new dog owner, this app helped me find a whole '
          'community. Couldn\'t recommend it more.',
      owner: 'Tom & Biscuit',
      location: 'York',
    ),
    (
      text: 'My rescue was nervous around other dogs. The temperament '
          'matching helped us find calm, patient playmates.',
      owner: 'Priya & Mango',
      location: 'Sheffield',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppBreakpoints.tablet;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sectionLarge,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxContent),
          child: Column(
            children: [
              const SectionHeader(
                overline: 'Happy Tails',
                title: 'The Proof Is In The Pets',
              ),
              const SizedBox(height: 56),
              isMobile
                  ? Column(
                      children: _testimonials
                          .map((t) => Padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppSpacing.xl),
                                child: _TestimonialCard(
                                  text: t.text,
                                  owner: t.owner,
                                  location: t.location,
                                ),
                              ))
                          .toList(),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _testimonials
                          .map((t) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: _TestimonialCard(
                                    text: t.text,
                                    owner: t.owner,
                                    location: t.location,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String text;
  final String owner;
  final String location;

  const _TestimonialCard({
    required this.text,
    required this.owner,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\u201C',
            style: AppTypography.displayMedium.copyWith(
              color: AppColors.coral.withOpacity(0.3),
              height: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: AppTypography.bodyMedium.copyWith(
              fontStyle: FontStyle.italic,
              color: AppColors.textPrimary.withOpacity(0.8),
              height: 1.7,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            owner,
            style: AppTypography.labelMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(location, style: AppTypography.bodySmall),
        ],
      ),
    );
  }
}
