/// Fertilizer Calculator Screen
/// 
/// Calculate NPK requirements based on crop type and area

library fertilizer_calculator_screen;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../services/gemini_service.dart';

class FertilizerCalculatorScreen extends ConsumerStatefulWidget {
  const FertilizerCalculatorScreen({super.key});

  @override
  ConsumerState<FertilizerCalculatorScreen> createState() => _FertilizerCalculatorScreenState();
}

class _FertilizerCalculatorScreenState extends ConsumerState<FertilizerCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedCrop = 'Rice';
  double _areaInAcres = 1.0;
  String? _result;
  bool _isCalculating = false;

  final List<String> _crops = [
    'Rice',
    'Wheat',
    'Cotton',
    'Sugarcane',
    'Maize',
    'Soybean',
    'Potato',
    'Tomato',
    'Onion',
    'Chilli',
  ];

  Future<void> _calculateFertilizer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isCalculating = true;
      _result = null;
    });

    try {
      final geminiService = ref.read(geminiServiceProvider);
      final result = await geminiService.calculateFertilizerRequirement(
        cropType: _selectedCrop,
        areaInAcres: _areaInAcres,
        language: 'English',
      );

      setState(() {
        _result = result;
        _isCalculating = false;
      });
    } catch (e) {
      setState(() => _isCalculating = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fertilizer Calculator'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                '🌱 Calculate NPK Requirements',
                style: AppTextStyles.h3,
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0),
              const SizedBox(height: AppDimensions.paddingSM),
              Text(
                'Get personalized fertilizer recommendations',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
              const SizedBox(height: AppDimensions.paddingXL),

              // Crop Selection
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.success.withOpacity(0.1),
                      AppColors.success.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                  border: Border.all(
                    color: AppColors.success.withOpacity(0.3),
                  ),
                ),
                padding: const EdgeInsets.all(AppDimensions.paddingLG),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Crop',
                      style: AppTextStyles.h5,
                    ),
                    const SizedBox(height: AppDimensions.paddingMD),
                    DropdownButtonFormField<String>(
                      value: _selectedCrop,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.eco, color: AppColors.success),
                        filled: true,
                        fillColor: AppColors.surface,
                      ),
                      items: _crops.map((crop) {
                        return DropdownMenuItem(
                          value: crop,
                          child: Text(crop),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedCrop = value!);
                      },
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideX(begin: -0.2, end: 0),
              const SizedBox(height: AppDimensions.paddingLG),

              // Area Input
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.info.withOpacity(0.1),
                      AppColors.info.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                  border: Border.all(
                    color: AppColors.info.withOpacity(0.3),
                  ),
                ),
                padding: const EdgeInsets.all(AppDimensions.paddingLG),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Land Area',
                      style: AppTextStyles.h5,
                    ),
                    const SizedBox(height: AppDimensions.paddingMD),
                    TextFormField(
                      initialValue: _areaInAcres.toString(),
                      decoration: InputDecoration(
                        labelText: 'Area in Acres',
                        prefixIcon: Icon(Icons.landscape, color: AppColors.info),
                        suffixText: 'acres',
                        filled: true,
                        fillColor: AppColors.surface,
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter area';
                        }
                        final area = double.tryParse(value);
                        if (area == null || area <= 0) {
                          return 'Please enter valid area';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final area = double.tryParse(value);
                        if (area != null && area > 0) {
                          setState(() => _areaInAcres = area);
                        }
                      },
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 300.ms).slideX(begin: -0.2, end: 0),
              const SizedBox(height: AppDimensions.paddingXL),

              // Calculate Button
              Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.success, AppColors.success.withOpacity(0.8)],
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.success.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _isCalculating ? null : _calculateFertilizer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                    ),
                  ),
                  child: _isCalculating
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: AppColors.textLight,
                            strokeWidth: 2,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calculate, color: AppColors.textLight),
                            const SizedBox(width: 8),
                            Text(
                              'Calculate Requirements',
                              style: AppTextStyles.button,
                            ),
                          ],
                        ),
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 400.ms).scale(),
              const SizedBox(height: AppDimensions.paddingXL),

              // Result
              if (_result != null)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(AppDimensions.paddingLG),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.success, AppColors.success.withOpacity(0.7)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.check_circle,
                              color: AppColors.textLight,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Fertilizer Recommendations',
                              style: AppTextStyles.h4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.paddingLG),
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.paddingMD),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                        ),
                        child: Text(
                          _result!,
                          style: AppTextStyles.bodyMedium.copyWith(height: 1.6),
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.3, end: 0)
                    .shimmer(duration: 1000.ms, color: AppColors.success.withOpacity(0.2)),
            ],
          ),
        ),
      ),
    );
  }
}
