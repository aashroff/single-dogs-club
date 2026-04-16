import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../models/dog_profile.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  RangeValues _ageRange = const RangeValues(0, 15);
  Set<DogSize> _selectedSizes = {};
  Set<ActivityLevel> _selectedActivity = {};
  Set<Temperament> _selectedTemperament = {};
  double _maxDistance = 25;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.xxl),
            ),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textHint.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filters', style: AppTypography.headlineMedium),
                  TextButton(
                    onPressed: _resetFilters,
                    child: Text(
                      'Reset',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.coral,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Distance
              _SectionTitle('Maximum Distance'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _maxDistance,
                      min: 1,
                      max: 100,
                      divisions: 99,
                      activeColor: AppColors.coral,
                      onChanged: (v) => setState(() => _maxDistance = v),
                    ),
                  ),
                  SizedBox(
                    width: 56,
                    child: Text(
                      '${_maxDistance.round()} km',
                      style: AppTypography.labelMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Age range
              _SectionTitle('Dog Age'),
              const SizedBox(height: 8),
              RangeSlider(
                values: _ageRange,
                min: 0,
                max: 15,
                divisions: 15,
                activeColor: AppColors.coral,
                labels: RangeLabels(
                  '${_ageRange.start.round()} yrs',
                  '${_ageRange.end.round()} yrs',
                ),
                onChanged: (v) => setState(() => _ageRange = v),
              ),
              const SizedBox(height: 24),

              // Size
              _SectionTitle('Size'),
              const SizedBox(height: 12),
              _ChipGroup<DogSize>(
                values: DogSize.values,
                selected: _selectedSizes,
                labelFn: (v) => v.name[0].toUpperCase() + v.name.substring(1),
                onChanged: (v) => setState(() => _selectedSizes = v),
              ),
              const SizedBox(height: 24),

              // Activity Level
              _SectionTitle('Activity Level'),
              const SizedBox(height: 12),
              _ChipGroup<ActivityLevel>(
                values: ActivityLevel.values,
                selected: _selectedActivity,
                labelFn: (v) => v.name[0].toUpperCase() + v.name.substring(1),
                onChanged: (v) => setState(() => _selectedActivity = v),
              ),
              const SizedBox(height: 24),

              // Temperament
              _SectionTitle('Temperament'),
              const SizedBox(height: 12),
              _ChipGroup<Temperament>(
                values: Temperament.values,
                selected: _selectedTemperament,
                labelFn: (v) => v.name[0].toUpperCase() + v.name.substring(1),
                onChanged: (v) => setState(() => _selectedTemperament = v),
              ),
              const SizedBox(height: 32),

              // Apply button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Apply filters via Riverpod state
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _resetFilters() {
    setState(() {
      _ageRange = const RangeValues(0, 15);
      _selectedSizes = {};
      _selectedActivity = {};
      _selectedTemperament = {};
      _maxDistance = 25;
    });
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.labelMedium.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),
    );
  }
}

class _ChipGroup<T> extends StatelessWidget {
  final List<T> values;
  final Set<T> selected;
  final String Function(T) labelFn;
  final ValueChanged<Set<T>> onChanged;

  const _ChipGroup({
    required this.values,
    required this.selected,
    required this.labelFn,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: values.map((v) {
        final isSelected = selected.contains(v);
        return FilterChip(
          label: Text(labelFn(v)),
          selected: isSelected,
          selectedColor: AppColors.coral.withOpacity(0.15),
          checkmarkColor: AppColors.coral,
          labelStyle: AppTypography.tag.copyWith(
            color: isSelected ? AppColors.coral : AppColors.textSecondary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? AppColors.coral : AppColors.border,
            ),
          ),
          onSelected: (sel) {
            final next = Set<T>.from(selected);
            sel ? next.add(v) : next.remove(v);
            onChanged(next);
          },
        );
      }).toList(),
    );
  }
}
