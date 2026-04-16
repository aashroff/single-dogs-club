import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/section_header.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const _features = [
    (
      icon: '\uD83D\uDD0D',
      title: 'Smart Matching',
      desc: 'Filter by breed, size, temperament, activity level, '
          'and owner preferences to find the perfect playmate.',
    ),
    (
      icon: '\uD83D\uDDFA\uFE0F',
      title: 'Walk Finder',
      desc: 'Discover dog walks near you with our interactive map. '
          'Read reviews and share your favourites.',
    ),
    (
      icon: '\u2615',
      title: 'Dog-Friendly Places',
      desc: 'Find cafes, pubs, restaurants, and hotels that welcome '
          'your four-legged friend.',
    ),
    (
      icon: '\u2B50',
      title: 'Rate & Review',
      desc: 'Share your experiences. Rate walks, venues, and doggy '
          'dates to help the community.',
    ),
    (
      icon: '\uD83D\uDC3E',
      title: 'Local Services',
      desc: 'Dog walkers, groomers, physios, pet sitters, vets, and '
          'pet shops all in one place.',
    ),
    (
      icon: '\uD83D\uDCAC',
      title: 'Connect & Chat',
      desc: 'Message matched owners, arrange meet-ups, and build '
          'lasting friendships for you and your dog.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > AppBreakpoints.tablet
        ? 3
        : screenWidth > AppBreakpoints.mobile
            ? 2
            : 1;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.surfaceDim, AppColors.cream],
        ),
      ),
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
                overline: 'Everything You Need',
                overlineColor: AppColors.coral,
                title: 'Features',
              ),
              const SizedBox(height: 64),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: crossAxisCount == 1 ? 2.5 : 1.2,
                ),
                itemCount: _features.length,
                itemBuilder: (context, i) => _FeatureCard(
                  icon: _features[i].icon,
                  title: _features[i].title,
                  desc: _features[i].desc,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final String icon;
  final String title;
  final String desc;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translate(0.0, _hovering ? -4.0 : 0.0),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: _hovering
                ? AppColors.coral.withOpacity(0.2)
                : AppColors.border,
          ),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.icon, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 16),
            Text(widget.title, style: AppTypography.headlineSmall),
            const SizedBox(height: 10),
            Text(
              widget.desc,
              style: AppTypography.bodyMedium,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
