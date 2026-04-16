import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/section_header.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  static const _steps = [
    (
      step: '01',
      title: 'Create Profiles',
      desc: 'Register you and your dog. Add photos, temperament, '
          'favourite walks, and what you\'re looking for.',
      icon: '\uD83D\uDCDD',
    ),
    (
      step: '02',
      title: 'Match & Connect',
      desc: 'Swipe through potential playmates or search with filters. '
          'Match on breed, energy, size, and more.',
      icon: '\uD83D\uDC9A',
    ),
    (
      step: '03',
      title: 'Meet & Walk',
      desc: 'Arrange walks, cafe dates, or park meet-ups. Rate your '
          'experience and grow the community.',
      icon: '\uD83D\uDC15',
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
                overline: 'Simple Steps',
                title: 'How It Works',
                subtitle: 'From sign-up to first walk in minutes. '
                    'Finding your dog\'s new best friend has never been easier.',
              ),
              const SizedBox(height: 64),
              isMobile
                  ? Column(
                      children: _steps
                          .map((s) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: AppSpacing.xl),
                                child: _StepCard(
                                  step: s.step,
                                  title: s.title,
                                  desc: s.desc,
                                  icon: s.icon,
                                  isHighlighted: s.step == '02',
                                ),
                              ))
                          .toList(),
                    )
                  : Stack(
                      children: [
                        // Connecting line
                        Positioned(
                          top: 48,
                          left: screenWidth * 0.12,
                          right: screenWidth * 0.12,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.coral.withOpacity(0.25),
                                  AppColors.sage.withOpacity(0.25),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _steps
                              .map((s) => Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppSpacing.lg),
                                      child: _StepCard(
                                        step: s.step,
                                        title: s.title,
                                        desc: s.desc,
                                        icon: s.icon,
                                        isHighlighted: s.step == '02',
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepCard extends StatefulWidget {
  final String step;
  final String title;
  final String desc;
  final String icon;
  final bool isHighlighted;

  const _StepCard({
    required this.step,
    required this.title,
    required this.desc,
    required this.icon,
    this.isHighlighted = false,
  });

  @override
  State<_StepCard> createState() => _StepCardState();
}

class _StepCardState extends State<_StepCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translate(0.0, _hovering ? -6.0 : 0.0),
        padding: const EdgeInsets.fromLTRB(28, 40, 28, 32),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovering ? 0.08 : 0.04),
              blurRadius: _hovering ? 32 : 20,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: widget.isHighlighted
                    ? AppColors.coralGradient
                    : null,
                color: widget.isHighlighted
                    ? null
                    : AppColors.sage.withOpacity(0.12),
                shape: BoxShape.circle,
                boxShadow: widget.isHighlighted
                    ? [
                        BoxShadow(
                          color: AppColors.coral.withOpacity(0.25),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(widget.icon, style: const TextStyle(fontSize: 32)),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'STEP ${widget.step}',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.coral,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              style: AppTypography.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              widget.desc,
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
