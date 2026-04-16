import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../models/dog_profile.dart';
import '../widgets/swipe_card.dart';
import '../widgets/filter_sheet.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool _isSwipeMode = true;

  // Placeholder profiles for demo
  final _demoProfiles = [
    DogProfile(
      id: '1', name: 'Max', breed: 'Golden Retriever', ageYears: 3,
      size: DogSize.large, activityLevel: ActivityLevel.high,
      temperament: Temperament.playful, sex: DogSex.male,
      isNeutered: true, bio: 'Loves swimming and long beach walks!',
      photoUrls: [], ownerId: 'u1', createdAt: DateTime.now(),
    ),
    DogProfile(
      id: '2', name: 'Cooper', breed: 'Chocolate Lab', ageYears: 5,
      size: DogSize.large, activityLevel: ActivityLevel.medium,
      temperament: Temperament.friendly, sex: DogSex.male,
      isNeutered: true, bio: 'Forest trails and cosy pub stops.',
      photoUrls: [], ownerId: 'u2', createdAt: DateTime.now(),
    ),
    DogProfile(
      id: '3', name: 'Buddy', breed: 'French Bulldog', ageYears: 2,
      size: DogSize.small, activityLevel: ActivityLevel.low,
      temperament: Temperament.calm, sex: DogSex.male,
      isNeutered: true, bio: 'Short strolls and lots of snoring.',
      photoUrls: [], ownerId: 'u3', createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover',
          style: AppTypography.headlineMedium,
        ),
        actions: [
          // Toggle swipe / list view
          IconButton(
            icon: Icon(
              _isSwipeMode ? Icons.grid_view_rounded : Icons.swipe_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () => setState(() => _isSwipeMode = !_isSwipeMode),
          ),
          // Filter
          IconButton(
            icon: const Icon(Icons.tune_rounded, color: AppColors.textPrimary),
            onPressed: () => _showFilters(context),
          ),
        ],
      ),
      body: _isSwipeMode
          ? _SwipeView(profiles: _demoProfiles)
          : _ListView(profiles: _demoProfiles),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      builder: (_) => const FilterSheet(),
    );
  }
}

class _SwipeView extends StatelessWidget {
  final List<DogProfile> profiles;

  const _SwipeView({required this.profiles});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Swipe card stack area
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: profiles.isEmpty
                      ? _EmptyState()
                      // TODO: Replace with flutter_card_swiper CardSwiper
                      : SwipeCard(profile: profiles.first),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ActionButton(
                  icon: Icons.close_rounded,
                  color: AppColors.coralPale,
                  iconColor: AppColors.coralDark,
                  onTap: () {
                    // TODO: Reject / pass
                  },
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  icon: Icons.star_rounded,
                  color: const Color(0xFFFFF8E1),
                  iconColor: AppColors.warning,
                  onTap: () {
                    // TODO: Super like
                  },
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  icon: Icons.favorite_rounded,
                  color: AppColors.sagePale,
                  iconColor: AppColors.sageDark,
                  size: 60,
                  onTap: () {
                    // TODO: Like / match
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final double size;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.iconColor,
    this.size = 48,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: size * 0.45),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  final List<DogProfile> profiles;

  const _ListView({required this.profiles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.xl),
      itemCount: profiles.length,
      itemBuilder: (context, i) {
        final dog = profiles[i];
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.lg),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              // Dog avatar placeholder
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.sand,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Center(
                  child: Text('\uD83D\uDC36', style: TextStyle(fontSize: 32)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dog.name, style: AppTypography.headlineSmall),
                    const SizedBox(height: 4),
                    Text(
                      '${dog.breed} \u00B7 ${dog.ageYears} yrs',
                      style: AppTypography.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _Tag(label: dog.temperamentLabel, color: AppColors.sage),
                        _Tag(label: '${dog.activityLabel} energy', color: AppColors.coral),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;

  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTypography.tag.copyWith(color: color),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('\uD83C\uDF89', style: TextStyle(fontSize: 48)),
        const SizedBox(height: 16),
        Text('You\'ve seen them all!', style: AppTypography.headlineSmall),
        const SizedBox(height: 8),
        Text('More pups are joining every day', style: AppTypography.bodySmall),
      ],
    );
  }
}
