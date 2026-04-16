import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  String _ownerType = 'Single';
  String _matchPref = 'Friends only';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: AppTypography.headlineMedium),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Save profile
              Navigator.of(context).pop();
            },
            child: Text('Save', style: AppTypography.labelMedium.copyWith(color: AppColors.coral)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        children: [
          // Avatar
          Center(
            child: Stack(
              children: [
                Container(
                  width: 96, height: 96,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.sand,
                  ),
                  child: const Center(child: Text('\uD83D\uDC64', style: TextStyle(fontSize: 40))),
                ),
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    width: 32, height: 32,
                    decoration: const BoxDecoration(
                      gradient: AppColors.coralGradient,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Form fields
          _FormField(label: 'Display Name', controller: _nameController, hint: 'Your name'),
          const SizedBox(height: 16),
          _FormField(label: 'Location', controller: _locationController, hint: 'City or town'),
          const SizedBox(height: 16),

          Text('Owner Type', style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['Single', 'Couple', 'Family'].map((t) {
              final selected = _ownerType == t;
              return ChoiceChip(
                label: Text(t),
                selected: selected,
                selectedColor: AppColors.coral.withOpacity(0.15),
                onSelected: (_) => setState(() => _ownerType = t),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          Text('Match Preference', style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['Friends only', 'Open to all'].map((t) {
              final selected = _matchPref == t;
              return ChoiceChip(
                label: Text(t),
                selected: selected,
                selectedColor: AppColors.coral.withOpacity(0.15),
                onSelected: (_) => setState(() => _matchPref = t),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;

  const _FormField({required this.label, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextField(controller: controller, decoration: InputDecoration(hintText: hint)),
      ],
    );
  }
}
