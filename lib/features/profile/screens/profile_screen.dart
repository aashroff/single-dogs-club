import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AppTypography.headlineMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Open settings
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        children: [
          // Profile header
          Center(
            child: Column(
              children: [
                Container(
                  width: 96, height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.sand,
                    border: Border.all(color: AppColors.coral.withOpacity(0.3), width: 3),
                  ),
                  child: const Center(child: Text('\uD83D\uDC64', style: TextStyle(fontSize: 40))),
                ),
                const SizedBox(height: 16),
                Text('Your Name', style: AppTypography.headlineMedium),
                const SizedBox(height: 4),
                Text('Scunthorpe \u00B7 Joined 2026', style: AppTypography.bodySmall),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () => context.go('/profile/edit'),
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // My Dogs section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Dogs', style: AppTypography.headlineSmall),
              TextButton.icon(
                onPressed: () => context.go('/profile/add-dog'),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add Dog'),
                style: TextButton.styleFrom(foregroundColor: AppColors.coral),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Dog card placeholder
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 72, height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.sand,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: const Center(child: Text('\uD83D\uDC36', style: TextStyle(fontSize: 36))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add your first dog', style: AppTypography.headlineSmall.copyWith(fontSize: 18)),
                      const SizedBox(height: 4),
                      Text('Create a profile to start matching', style: AppTypography.bodySmall),
                    ],
                  ),
                ),
                const Icon(Icons.add_circle_outline_rounded, color: AppColors.coral),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Stats
          Text('Activity', style: AppTypography.headlineSmall),
          const SizedBox(height: 16),
          Row(
            children: [
              _StatCard(value: '0', label: 'Matches', color: AppColors.coral),
              const SizedBox(width: 12),
              _StatCard(value: '0', label: 'Walks', color: AppColors.sage),
              const SizedBox(width: 12),
              _StatCard(value: '0', label: 'Reviews', color: AppColors.warning),
            ],
          ),
          const SizedBox(height: 32),

          // Menu items
          ..._menuItems.map((item) => _MenuItem(
            icon: item.icon,
            label: item.label,
            onTap: () {},
          )),

          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () {
                // TODO: Sign out
                context.go('/');
              },
              child: Text(
                'Sign Out',
                style: AppTypography.labelMedium.copyWith(color: AppColors.coralDark),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatCard({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Column(
          children: [
            Text(value, style: AppTypography.headlineLarge.copyWith(color: color)),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.bodySmall),
          ],
        ),
      ),
    );
  }
}

final _menuItems = [
  (icon: Icons.bookmark_outline_rounded, label: 'Saved Walks'),
  (icon: Icons.star_outline_rounded, label: 'My Reviews'),
  (icon: Icons.notifications_outlined, label: 'Notifications'),
  (icon: Icons.help_outline_rounded, label: 'Help & Support'),
  (icon: Icons.info_outline_rounded, label: 'About'),
];

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(label, style: AppTypography.labelMedium),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
      onTap: onTap,
    );
  }
}
