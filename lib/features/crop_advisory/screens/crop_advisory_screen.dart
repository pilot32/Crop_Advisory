/// Crop Advisory Screen
/// 
/// Provides personalized crop recommendations based on soil and location

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class CropAdvisoryScreen extends ConsumerStatefulWidget {
  const CropAdvisoryScreen({super.key});

  @override
  ConsumerState<CropAdvisoryScreen> createState() => _CropAdvisoryScreenState();
}

class _CropAdvisoryScreenState extends ConsumerState<CropAdvisoryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedSoilType;
  String? _selectedSeason;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _previousCropController = TextEditingController();

  final List<String> _soilTypes = [
    'Alluvial Soil',
    'Black Soil',
    'Red Soil',
    'Laterite Soil',
    'Desert Soil',
    'Mountain Soil',
  ];

  final List<String> _seasons = [
    'Kharif (Monsoon)',
    'Rabi (Winter)',
    'Zaid (Summer)',
  ];

  @override
  void dispose() {
    _locationController.dispose();
    _previousCropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Advisory'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Get Personalized Crop Recommendations',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: AppDimensions.paddingSM),
              Text(
                'Fill in the details below to receive AI-powered crop suggestions based on your location, soil type, and season.',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingXL),

              // Location
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'Enter your village/district',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.paddingMD),

              // Soil Type
              DropdownButtonFormField<String>(
                value: _selectedSoilType,
                decoration: const InputDecoration(
                  labelText: 'Soil Type',
                  prefixIcon: Icon(Icons.grass_outlined),
                ),
                items: _soilTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedSoilType = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select soil type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.paddingMD),

              // Season
              DropdownButtonFormField<String>(
                value: _selectedSeason,
                decoration: const InputDecoration(
                  labelText: 'Season',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                ),
                items: _seasons.map((season) {
                  return DropdownMenuItem(
                    value: season,
                    child: Text(season),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedSeason = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select season';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.paddingMD),

              // Previous Crop (Optional)
              TextFormField(
                controller: _previousCropController,
                decoration: const InputDecoration(
                  labelText: 'Previous Crop (Optional)',
                  hintText: 'What did you grow last season?',
                  prefixIcon: Icon(Icons.agriculture_outlined),
                ),
              ),
              const SizedBox(height: AppDimensions.paddingXL),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _getRecommendations,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(AppDimensions.paddingMD),
                  ),
                  child: const Text('Get Recommendations'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getRecommendations() {
    if (_formKey.currentState!.validate()) {
      // TODO: Integrate with Gemini service for recommendations
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Crop Recommendations'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Based on your inputs:',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingMD),
              _buildRecommendationItem('Rice', 'High yield potential in your soil'),
              _buildRecommendationItem('Wheat', 'Good for current season'),
              _buildRecommendationItem('Sugarcane', 'Profitable crop option'),
              const SizedBox(height: AppDimensions.paddingMD),
              Text(
                'Note: This is a demo. AI integration coming soon!',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.info,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildRecommendationItem(String crop, String reason) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.success,
            size: AppDimensions.iconSM,
          ),
          const SizedBox(width: AppDimensions.paddingSM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crop,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  reason,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
