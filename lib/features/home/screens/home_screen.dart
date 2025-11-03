/// Home Screen
/// 
/// Main dashboard showing all app features and quick access cards

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../widgets/feature_card.dart';
import '../widgets/weather_card.dart';
import '../widgets/quick_action_button.dart';
import '../../auth/providers/simple_auth_provider.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon')),
              );
            },
          ),
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
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Text(
            'Welcome back${user?.email != null ? ', Farmer' : ''}!',
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: AppDimensions.paddingSM),
          Text(
            'How can we help you today?',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLG),

          // Weather Card
          const WeatherCard(),
          const SizedBox(height: AppDimensions.paddingLG),

          // Quick Actions
          Text(
            'Quick Actions',
            style: AppTextStyles.h4,
          ),
          const SizedBox(height: AppDimensions.paddingMD),
          Row(
            children: [
              Expanded(
                child: QuickActionButton(
                  icon: Icons.chat,
                  label: 'Ask AI',
                  color: AppColors.primary,
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.chatbot);
                  },
                ),
              ),
              const SizedBox(width: AppDimensions.paddingMD),
              Expanded(
                child: QuickActionButton(
                  icon: Icons.camera_alt,
                  label: 'Scan Pest',
                  color: AppColors.accent,
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.pestDetection);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingLG),

          // Features Section
          Text(
            'Features',
            style: AppTextStyles.h4,
          ),
          const SizedBox(height: AppDimensions.paddingMD),

          FeatureCard(
            icon: Icons.eco,
            title: 'Crop Advisory',
            description: 'Get personalized crop recommendations',
            color: AppColors.success,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.cropAdvisory);
            },
          ),
          const SizedBox(height: AppDimensions.paddingMD),

          FeatureCard(
            icon: Icons.grass,
            title: 'Soil Health',
            description: 'Analyze soil and get fertilizer advice',
            color: AppColors.secondary,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.soilHealth);
            },
          ),
          const SizedBox(height: AppDimensions.paddingMD),

          FeatureCard(
            icon: Icons.cloud,
            title: 'Weather Forecast',
            description: 'Check weather alerts and forecasts',
            color: AppColors.info,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.weather);
            },
          ),
          const SizedBox(height: AppDimensions.paddingMD),

          FeatureCard(
            icon: Icons.bug_report,
            title: 'Pest Detection',
            description: 'Identify pests and diseases from images',
            color: AppColors.error,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.pestDetection);
            },
          ),
          const SizedBox(height: AppDimensions.paddingMD),

          FeatureCard(
            icon: Icons.show_chart,
            title: 'Market Prices',
            description: 'Track crop prices and trends',
            color: AppColors.accent,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.marketPrices);
            },
          ),
          const SizedBox(height: AppDimensions.paddingMD),
        ],
      ),
    );
  }

}
