import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  static const _categories = [
    (icon: Icons.directions_walk_rounded, label: 'Dog Walkers', color: AppColors.coral),
    (icon: Icons.content_cut_rounded, label: 'Groomers', color: AppColors.sage),
    (icon: Icons.pets_rounded, label: 'Pet Sitters', color: Color(0xFFF0A830)),
    (icon: Icons.healing_rounded, label: 'Dog Physios', color: Color(0xFF7B8EC8)),
    (icon: Icons.local_hospital_rounded, label: 'Vets', color: AppColors.coralDark),
    (icon: Icons.store_rounded, label: 'Pet Shops', color: AppColors.sageDark),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services', style: AppTypography.headlineMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              // TODO: Search services
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        children: [
          Text(
            'Find local services for your dog',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Category grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, i) {
              final cat = _categories[i];
              return _CategoryTile(
                icon: cat.icon,
                label: cat.label,
                color: cat.color,
                onTap: () {
                  // TODO: Navigate to category listing
                },
              );
            },
          ),

          const SizedBox(height: 32),
          Text('Popular Near You', style: AppTypography.headlineSmall),
          const SizedBox(height: 16),

          // Placeholder service cards
          ...List.generate(4, (i) => _ServiceCard(index: i)),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 10),
            Text(
              label,
              style: AppTypography.tag.copyWith(color: color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final int index;

  const _ServiceCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final names = ['Happy Paws Grooming', 'Walkies with Will', 'Paws & Claws Vet', 'The Dog House Supplies'];
    final types = ['Groomer', 'Dog Walker', 'Vet', 'Pet Shop'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: AppColors.sand,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(Icons.store_rounded, color: AppColors.textMuted),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(names[index % 4], style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('${types[index % 4]} \u00B7 ${(index + 1) * 0.8} km away', style: AppTypography.bodySmall),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 14, color: AppColors.warning),
                    const SizedBox(width: 4),
                    Text('4.${9 - index}', style: AppTypography.tag.copyWith(color: AppColors.textPrimary)),
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
