/// Language Selection Screen
/// 
/// First onboarding screen where users select their preferred language

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import 'onboarding_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'en';

  final List<LanguageOption> _languages = [
    LanguageOption(code: 'en', name: 'English', nativeName: 'English'),
    LanguageOption(code: 'hi', name: 'Hindi', nativeName: 'हिंदी'),
    LanguageOption(code: 'bn', name: 'Bengali', nativeName: 'বাংলা'),
    LanguageOption(code: 'te', name: 'Telugu', nativeName: 'తెలుగు'),
    LanguageOption(code: 'mr', name: 'Marathi', nativeName: 'मराठी'),
    LanguageOption(code: 'ta', name: 'Tamil', nativeName: 'தமிழ்'),
    LanguageOption(code: 'gu', name: 'Gujarati', nativeName: 'ગુજરાતી'),
    LanguageOption(code: 'kn', name: 'Kannada', nativeName: 'ಕನ್ನಡ'),
    LanguageOption(code: 'ml', name: 'Malayalam', nativeName: 'മലയാളം'),
    LanguageOption(code: 'pa', name: 'Punjabi', nativeName: 'ਪੰਜਾਬੀ'),
  ];

  Future<void> _saveLanguageAndContinue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.languagePreference, _selectedLanguage);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppDimensions.paddingXL),
              
              // App Icon
              Icon(
                Icons.agriculture,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppDimensions.paddingLG),
              
              // Title
              Text(
                'Choose Your Language',
                style: AppTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.paddingSM),
              
              Text(
                'अपनी भाषा चुनें | Select your preferred language',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.paddingXL),
              
              // Language List
              Expanded(
                child: ListView.builder(
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final language = _languages[index];
                    final isSelected = _selectedLanguage == language.code;
                    
                    return Card(
                      margin: const EdgeInsets.only(
                        bottom: AppDimensions.paddingMD,
                      ),
                      elevation: isSelected ? 4 : 1,
                      color: isSelected 
                          ? AppColors.primary.withOpacity(0.1)
                          : AppColors.surface,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingMD,
                          vertical: AppDimensions.paddingSM,
                        ),
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AppColors.primary 
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMD,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              language.code.toUpperCase(),
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isSelected 
                                    ? AppColors.textLight 
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          language.nativeName,
                          style: AppTextStyles.h5.copyWith(
                            color: isSelected 
                                ? AppColors.primary 
                                : AppColors.textPrimary,
                          ),
                        ),
                        subtitle: Text(
                          language.name,
                          style: AppTextStyles.bodySmall,
                        ),
                        trailing: isSelected
                            ? Icon(
                                Icons.check_circle,
                                color: AppColors.primary,
                                size: AppDimensions.iconMD,
                              )
                            : null,
                        onTap: () {
                          setState(() {
                            _selectedLanguage = language.code;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              
              // Continue Button
              ElevatedButton(
                onPressed: _saveLanguageAndContinue,
                child: const Text('Continue'),
              ),
              const SizedBox(height: AppDimensions.paddingMD),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageOption {
  final String code;
  final String name;
  final String nativeName;

  LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
  });
}
