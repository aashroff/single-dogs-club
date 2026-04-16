import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore', style: AppTypography.headlineMedium),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.coral,
          unselectedLabelColor: AppColors.textMuted,
          indicatorColor: AppColors.coral,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppTypography.labelMedium,
          tabs: const [
            Tab(text: 'Walks'),
            Tab(text: 'Places'),
            Tab(text: 'Nearby'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _WalksTab(),
          _PlacesTab(),
          _NearbyTab(),
        ],
      ),
    );
  }
}

class _WalksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map placeholder
        Container(
          color: AppColors.surfaceDim,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.map_rounded, size: 64, color: AppColors.textHint),
                const SizedBox(height: 12),
                Text(
                  'Google Maps integration',
                  style: AppTypography.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Add your Google Maps API key\nto enable the map view',
                  style: AppTypography.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        // Bottom sheet with walk list
        DraggableScrollableSheet(
          initialChildSize: 0.35,
          minChildSize: 0.15,
          maxChildSize: 0.85,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.xxl),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 40, height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.textHint.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Walks Near You', style: AppTypography.headlineSmall),
                  const SizedBox(height: 16),
                  ...List.generate(5, (i) => _WalkCard(index: i)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _WalkCard extends StatelessWidget {
  final int index;

  const _WalkCard({required this.index});

  static const _names = [
    'Normanby Hall Country Park',
    'Humber Bridge Walk',
    'Cleethorpes Beach',
    'Brumby Woods',
    'Ashby Decoy',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: AppColors.sage.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(Icons.park_rounded, color: AppColors.sage),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _names[index % _names.length],
                  style: AppTypography.labelMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(index + 1) * 1.2} km \u00B7 Easy \u00B7 Off-lead areas',
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 14, color: AppColors.warning),
                    const SizedBox(width: 4),
                    Text(
                      '4.${8 - index}',
                      style: AppTypography.tag.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      ' (${42 + index * 7} reviews)',
                      style: AppTypography.bodySmall.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class _PlacesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PlaceholderTab(
      icon: Icons.restaurant_rounded,
      title: 'Dog-Friendly Places',
      subtitle: 'Cafes, pubs, restaurants and hotels\nthat welcome your dog.',
    );
  }
}

class _NearbyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PlaceholderTab(
      icon: Icons.near_me_rounded,
      title: 'Dogs Nearby',
      subtitle: 'See who\'s out and about\nin your area right now.',
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PlaceholderTab({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: AppColors.textHint),
          const SizedBox(height: 16),
          Text(title, style: AppTypography.headlineSmall),
          const SizedBox(height: 8),
          Text(subtitle, style: AppTypography.bodySmall, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
