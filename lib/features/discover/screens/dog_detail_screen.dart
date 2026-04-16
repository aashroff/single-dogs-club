import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';

class DogDetailScreen extends StatelessWidget {
  final String dogId;

  const DogDetailScreen({super.key, required this.dogId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Photo gallery header
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: AppColors.surface,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.sand,
                child: const Center(
                  child: Text('\uD83D\uDC36', style: TextStyle(fontSize: 100)),
                ),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: AppColors.surface.withOpacity(0.9),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and basic info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dog Name', style: AppTypography.displaySmall),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.sagePale,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '2 km away',
                          style: AppTypography.tag.copyWith(
                            color: AppColors.sageDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Golden Retriever \u00B7 3 years \u00B7 Male',
                    style: AppTypography.bodyLarge,
                  ),
                  const SizedBox(height: 24),

                  // Tags row
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _DetailTag('Playful', AppColors.sage),
                      _DetailTag('High Energy', AppColors.coral),
                      _DetailTag('Large', AppColors.textSecondary),
                      _DetailTag('Neutered', AppColors.sage),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // About section
                  Text('About', style: AppTypography.headlineSmall),
                  const SizedBox(height: 12),
                  Text(
                    'Loves swimming and long beach walks! Always up '
                    'for an adventure and great with other dogs of all sizes.',
                    style: AppTypography.bodyMedium.copyWith(height: 1.7),
                  ),
                  const SizedBox(height: 32),

                  // Owner section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDim,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: AppColors.sand,
                          child: const Text('\uD83D\uDC64',
                              style: TextStyle(fontSize: 28)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Owner Name',
                                style: AppTypography.labelMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Manchester \u00B7 Joined 2025',
                                style: AppTypography.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Send match request
                          },
                          icon: const Icon(Icons.favorite_rounded, size: 20),
                          label: const Text('Match'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Send message
                          },
                          icon: const Icon(Icons.chat_bubble_outline, size: 20),
                          label: const Text('Message'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailTag extends StatelessWidget {
  final String label;
  final Color color;

  const _DetailTag(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
