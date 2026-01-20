/// Home Screen
///
/// Main dashboard showing all app features and quick access cards

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/utils/animated_page_route.dart';
import '../widgets/feature_card.dart';
import '../widgets/weather_card.dart';
import '../widgets/quick_action_button.dart';
import '../../auth/providers/simple_auth_provider.dart';
import '../../chatbot/screens/chatbot_screen.dart';
import '../../pest_detection/screens/pest_detection_screen.dart';
import '../../crop_advisory/screens/crop_advisory_screen.dart';
import '../../soil_health/screens/soil_health_screen.dart';
import '../../weather/screens/weather_screen.dart';
import '../../market_prices/screens/market_prices_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  void _handleNavigation(int index) {
    if (index == _selectedIndex && index == 0) return;

    switch (index) {
      case 0:
        // Already on home, just reset the index
        setState(() => _selectedIndex = 0);
        break;
      case 1:
        Navigator.of(context).pushNamed(Routes.chatbot).then((_) {
          setState(() => _selectedIndex = 0);
        });
        break;
      case 2:
        Navigator.of(context).pushNamed(Routes.cropAdvisory).then((_) {
          setState(() => _selectedIndex = 0);
        });
        break;
      case 3:
        Navigator.of(context).pushNamed(Routes.marketPrices).then((_) {
          setState(() => _selectedIndex = 0);
        });
        break;
      case 4:
        Navigator.of(context).pushNamed(Routes.profile).then((_) {
          setState(() => _selectedIndex = 0);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
        elevation: 0,
        actions: [
          // Theme toggle
          IconButton(
            icon: Icon(
              ref.watch(themeMode$Provider) == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              ref.read(themeMode$Provider.notifier).toggle();
            },
          ).animate().fadeIn(duration: 300.ms).scale(),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon')),
              );
            },
          ).animate().fadeIn(duration: 300.ms, delay: 100.ms).scale(),
          const SizedBox(width: 8),
        ],
      ),
      body: _buildHomeContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _handleNavigation,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'AI Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco_outlined),
            activeIcon: Icon(Icons.eco),
            label: 'Advisory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            activeIcon: Icon(Icons.show_chart),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    final user = ref.watch(currentUserProvider);
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section with animation
          Text(
            user?.email != null ? l10n.welcomeBackFarmer : l10n.welcomeBack,
            style: AppTextStyles.h3,
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0),
          const SizedBox(height: AppDimensions.paddingSM),
          Text(
                l10n.howCanWeHelpYou,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 100.ms)
              .slideX(begin: -0.2, end: 0),
          const SizedBox(height: AppDimensions.paddingLG),

          // Weather Card with animation
          const WeatherCard()
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms)
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: AppDimensions.paddingLG),

          // Quick Actions with animation
          Text(l10n.quickActions, style: AppTextStyles.h4)
              .animate()
              .fadeIn(duration: 400.ms, delay: 300.ms)
              .slideX(begin: -0.2, end: 0),
          const SizedBox(height: AppDimensions.paddingMD),
          Row(
            children: [
              Expanded(
                child:
                    QuickActionButton(
                          icon: Icons.chat,
                          label: l10n.askAI,
                          color: AppColors.primary,
                          onTap: () {
                            context.pushWithSlide(const ChatbotScreen());
                          },
                        )
                        .animate()
                        .fadeIn(duration: 500.ms, delay: 400.ms)
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                        ),
              ),
              const SizedBox(width: AppDimensions.paddingMD),
              Expanded(
                child:
                    QuickActionButton(
                          icon: Icons.camera_alt,
                          label: l10n.scanPest,
                          color: AppColors.accent,
                          onTap: () {
                            context.pushWithSlide(const PestDetectionScreen());
                          },
                        )
                        .animate()
                        .fadeIn(duration: 500.ms, delay: 500.ms)
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                        ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingLG),

          // Features Section with animation
          Text(l10n.features, style: AppTextStyles.h4)
              .animate()
              .fadeIn(duration: 400.ms, delay: 600.ms)
              .slideX(begin: -0.2, end: 0),
          const SizedBox(height: AppDimensions.paddingMD),

          FeatureCard(
                icon: Icons.eco,
                title: l10n.cropAdvisory,
                description: l10n.cropAdvisoryDesc,
                color: AppColors.success,
                onTap: () => context.pushWithSlide(const CropAdvisoryScreen()),
              )
              .animate()
              .fadeIn(duration: 500.ms, delay: 700.ms)
              .slideX(begin: -0.3, end: 0),
          const SizedBox(height: AppDimensions.paddingMD),

          FeatureCard(
                icon: Icons.grass,
                title: l10n.soilHealth,
                description: l10n.soilHealthDesc,
                color: AppColors.secondary,
                onTap: () => context.pushWithSlide(const SoilHealthScreen()),
              )
              .animate()
              .fadeIn(duration: 500.ms, delay: 800.ms)
              .slideX(begin: -0.3, end: 0),
          const SizedBox(height: AppDimensions.paddingMD),

          FeatureCard(
                icon: Icons.cloud,
                title: l10n.weatherForecast,
                description: l10n.weatherForecastDesc,
                color: AppColors.info,
                onTap: () => context.pushWithSlide(const WeatherScreen()),
              )
              .animate()
              .fadeIn(duration: 500.ms, delay: 900.ms)
              .slideX(begin: -0.3, end: 0),
          const SizedBox(height: AppDimensions.paddingMD),

          FeatureCard(
                icon: Icons.bug_report,
                title: l10n.pestDetection,
                description: l10n.pestDetectionDesc,
                color: AppColors.error,
                onTap: () => context.pushWithSlide(const PestDetectionScreen()),
              )
              .animate()
              .fadeIn(duration: 500.ms, delay: 1000.ms)
              .slideX(begin: -0.3, end: 0),
          const SizedBox(height: AppDimensions.paddingMD),

          FeatureCard(
                icon: Icons.show_chart,
                title: l10n.marketPrices,
                description: l10n.marketPricesDesc,
                color: AppColors.accent,
                onTap: () => context.pushWithSlide(const MarketPricesScreen()),
              )
              .animate()
              .fadeIn(duration: 500.ms, delay: 1100.ms)
              .slideX(begin: -0.3, end: 0),
          const SizedBox(height: AppDimensions.paddingMD),
        ],
      ),
    );
  }
}
