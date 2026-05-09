/// Crop Advisory Screen
/// 
/// Provides personalized crop recommendations based on soil and location

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _speechAvailable = false;
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
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    final permission = await Permission.microphone.status;
    if (!permission.isGranted) {
      if (mounted) {
        setState(() => _speechAvailable = false);
      }
      return;
    }

    final available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          if (mounted) setState(() => _isListening = false);
        }
      },
      onError: (error) {
        if (mounted) setState(() => _isListening = false);
      },
    );
    if (mounted) setState(() => _speechAvailable = available);
  }

  @override
  void dispose() {
    _speech.cancel();
    _locationController.dispose();
    _previousCropController.dispose();
    super.dispose();
  }
  //toggle voice mode method to start and stop listening
  Future<void> _toggleVoiceInput() async {
    final permission = await Permission.microphone.request();
    if (!permission.isGranted) {
      if (permission.isPermanentlyDenied) {
        await openAppSettings();
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission is required for speech input')),
        );
      }
      return;
    }

    if (!_speechAvailable) {
      await _initSpeech();
      if (!_speechAvailable) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Speech recognition not available on this device')),
          );
        }
        return;
      }
    }

    if (_isListening) {
      await _speech.stop();
      if (mounted) setState(() => _isListening = false);
    } else {
      if (mounted) setState(() => _isListening = true);
      await _speech.listen(
        onResult: (result) {
          if (mounted) {
            setState(() {
              _locationController.text = result.recognizedWords;
            });
          }
        },
        localeId: 'en_IN',
        listenMode: stt.ListenMode.confirmation,
      );
    }
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
                            // Location
              TextFormField(
                controller: _locationController,
                readOnly: _isListening,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: _isListening ? 'Listening...' : 'Location',
                  hintText: 'Enter your village/district or tap mic',
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  suffixIcon: IconButton(
                    tooltip: _speechAvailable
                        ? (_isListening ? 'Stop listening' : 'Start voice input')
                        : 'Speech recognition unavailable',
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: _speechAvailable
                          ? (_isListening ? AppColors.error : AppColors.primary)
                          : AppColors.textHint,
                    ),
                    onPressed: _toggleVoiceInput,
                  ),
                  border: _isListening
                      ? const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.error, width: 2),
                        )
                      : null,
                  enabledBorder: _isListening
                      ? const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.error, width: 2),
                        )
                      : null,
                ),
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
