import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';

class SearchYourWaySection extends StatelessWidget {
  const SearchYourWaySection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppBreakpoints.tablet;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.sage.withOpacity(0.12),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: isMobile ? 60 : AppSpacing.sectionLarge,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxContent),
          child: Column(
            children: [
              Text(
                'Search your way...',
                style: AppTypography.displayMedium.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 48),

              // Three-column layout: Swipe card | Swipe or Search | Search list
              isMobile ? _MobileLayout() : _DesktopLayout(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Swipe card preview
        Expanded(child: _SwipePreview()),
        const SizedBox(width: 32),
        // Centre: Swipe or Search text
        Expanded(child: _SwipeOrSearch()),
        const SizedBox(width: 32),
        // Search list preview
        Expanded(child: _SearchListPreview()),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SwipeOrSearch(),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(child: _SwipePreview()),
            const SizedBox(width: 16),
            Expanded(child: _SearchListPreview()),
          ],
        ),
      ],
    );
  }
}

class _SwipePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mock profile photo area
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              image: const DecorationImage(
                image: AssetImage('assets/images/dog2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text('DoggyDates', style: AppTypography.headlineSmall),
          const SizedBox(height: 4),
          Text(
            'About Me',
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Looking for someone to join us on dog-friendly adventures!',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: 16),
          // Action buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _MiniAction(Icons.undo_rounded, AppColors.coral),
              const SizedBox(width: 10),
              _MiniAction(Icons.close_rounded, AppColors.coralDark),
              const SizedBox(width: 10),
              _MiniAction(Icons.star_rounded, const Color(0xFF5B9BD5)),
              const SizedBox(width: 10),
              _MiniAction(Icons.favorite_rounded, AppColors.sageDark),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _MiniAction(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        color: color.withOpacity(0.08),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}

class _SwipeOrSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.sage.withOpacity(0.15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Swipe...',
            style: AppTypography.displaySmall.copyWith(
              color: AppColors.coral,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          // Swipe arrow icon
          Icon(
            Icons.swipe_rounded,
            size: 64,
            color: AppColors.coral.withOpacity(0.35),
          ),
          const SizedBox(height: 24),
          Text(
            'or search',
            style: AppTypography.displaySmall.copyWith(
              color: AppColors.coral,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          Icon(
            Icons.search_rounded,
            size: 64,
            color: AppColors.coral.withOpacity(0.35),
          ),
        ],
      ),
    );
  }
}

class _SearchListPreview extends StatelessWidget {
  static const _results = [
    ('Sarah & Max', 'Manchester', 28, 'Looking for fun dog-loving people to join me and my golden retriever Max on beach walks!'),
    ('Jake & Cooper', 'London', 32, 'Just me and my chocolate lab, Cooper, out looking for friends!'),
    ('Emily & Buddy', 'Birmingham', 30, 'Love shorter city walks followed by a drink at a dog-friendly pub.'),
    ('Chris & Rocky', 'Bristol', 33, 'My german shepherd, Rocky, and I are always up for an adventure.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _results.map((r) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar placeholder
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.sand,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/dog1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          r.$1,
                          style: AppTypography.labelMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          r.$2,
                          style: AppTypography.bodySmall.copyWith(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.sage.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Single',
                        style: AppTypography.tag.copyWith(
                          fontSize: 10,
                          color: AppColors.sageDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      r.$4,
                      style: AppTypography.bodySmall.copyWith(fontSize: 11),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.favorite_rounded,
                size: 18,
                color: AppColors.coral.withOpacity(0.5),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
