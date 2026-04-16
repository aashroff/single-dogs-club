import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../models/dog_profile.dart';

class AddDogScreen extends StatefulWidget {
  const AddDogScreen({super.key});

  @override
  State<AddDogScreen> createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _bioController = TextEditingController();
  int _age = 1;
  DogSize _size = DogSize.medium;
  ActivityLevel _activity = ActivityLevel.medium;
  Temperament _temperament = Temperament.friendly;
  DogSex _sex = DogSex.male;
  bool _isNeutered = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Dog', style: AppTypography.headlineMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        children: [
          // Photo upload area
          Center(
            child: Container(
              width: 120, height: 120,
              decoration: BoxDecoration(
                color: AppColors.sand,
                borderRadius: BorderRadius.circular(AppRadius.xxl),
                border: Border.all(color: AppColors.borderCoral, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_a_photo_rounded, color: AppColors.coral, size: 32),
                  const SizedBox(height: 8),
                  Text('Add Photo', style: AppTypography.tag.copyWith(color: AppColors.coral)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          _Field(label: 'Name', controller: _nameController, hint: 'Your dog\'s name'),
          const SizedBox(height: 16),
          _Field(label: 'Breed', controller: _breedController, hint: 'e.g. Labrador, Cockapoo'),
          const SizedBox(height: 16),

          // Age stepper
          Text('Age', style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                onPressed: () => setState(() { if (_age > 0) _age--; }),
                icon: const Icon(Icons.remove_circle_outline_rounded),
                color: AppColors.coral,
              ),
              Text('$_age years', style: AppTypography.headlineSmall),
              IconButton(
                onPressed: () => setState(() { if (_age < 20) _age++; }),
                icon: const Icon(Icons.add_circle_outline_rounded),
                color: AppColors.coral,
              ),
            ],
          ),
          const SizedBox(height: 16),

          _ChipSelector<DogSize>(
            label: 'Size',
            values: DogSize.values,
            selected: _size,
            labelFn: (v) => v.name[0].toUpperCase() + v.name.substring(1),
            onSelected: (v) => setState(() => _size = v),
          ),
          const SizedBox(height: 16),

          _ChipSelector<ActivityLevel>(
            label: 'Activity Level',
            values: ActivityLevel.values,
            selected: _activity,
            labelFn: (v) => v.name[0].toUpperCase() + v.name.substring(1),
            onSelected: (v) => setState(() => _activity = v),
          ),
          const SizedBox(height: 16),

          _ChipSelector<Temperament>(
            label: 'Temperament',
            values: Temperament.values,
            selected: _temperament,
            labelFn: (v) => v.name[0].toUpperCase() + v.name.substring(1),
            onSelected: (v) => setState(() => _temperament = v),
          ),
          const SizedBox(height: 16),

          _ChipSelector<DogSex>(
            label: 'Sex',
            values: DogSex.values,
            selected: _sex,
            labelFn: (v) => v.name[0].toUpperCase() + v.name.substring(1),
            onSelected: (v) => setState(() => _sex = v),
          ),
          const SizedBox(height: 16),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Neutered / Spayed', style: AppTypography.labelMedium),
            value: _isNeutered,
            activeColor: AppColors.coral,
            onChanged: (v) => setState(() => _isNeutered = v),
          ),
          const SizedBox(height: 16),

          _Field(label: 'Bio', controller: _bioController, hint: 'Tell us about your dog...', maxLines: 3),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Save dog profile via Riverpod / Firestore
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('Save Dog Profile'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _Field({required this.label, required this.controller, required this.hint, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextField(controller: controller, maxLines: maxLines, decoration: InputDecoration(hintText: hint)),
      ],
    );
  }
}

class _ChipSelector<T> extends StatelessWidget {
  final String label;
  final List<T> values;
  final T selected;
  final String Function(T) labelFn;
  final ValueChanged<T> onSelected;

  const _ChipSelector({
    required this.label,
    required this.values,
    required this.selected,
    required this.labelFn,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: values.map((v) => ChoiceChip(
            label: Text(labelFn(v)),
            selected: selected == v,
            selectedColor: AppColors.coral.withOpacity(0.15),
            onSelected: (_) => onSelected(v),
          )).toList(),
        ),
      ],
    );
  }
}
