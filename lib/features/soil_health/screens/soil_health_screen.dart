/// Soil Health Screen
/// 
/// Analyzes soil health and provides fertilizer recommendations

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class SoilHealthScreen extends ConsumerWidget {
  const SoilHealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Health'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Soil Health Analysis',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: AppDimensions.paddingSM),
            Text(
              'Analyze your soil health and get personalized fertilizer recommendations.',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXL),

            // Quick Actions
            _buildActionCard(
              context,
              icon: Icons.analytics_outlined,
              title: 'Analyze Soil',
              description: 'Get AI-powered soil analysis',
              color: AppColors.primary,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Feature coming soon')),
                );
              },
            ),
            const SizedBox(height: AppDimensions.paddingMD),

            _buildActionCard(
              context,
              icon: Icons.science_outlined,
              title: 'Fertilizer Calculator',
              description: 'Calculate fertilizer requirements',
              color: AppColors.success,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Feature coming soon')),
                );
              },
            ),
            const SizedBox(height: AppDimensions.paddingMD),

            _buildActionCard(
              context,
              icon: Icons.history_outlined,
              title: 'Soil Test History',
              description: 'View past soil test results',
              color: AppColors.info,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Feature coming soon')),
                );
              },
            ),
            const SizedBox(height: AppDimensions.paddingXL),

            // Info Section
            Text(
              'About Soil Health',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: AppDimensions.paddingMD),
            _buildInfoTile(
              icon: Icons.water_drop_outlined,
              title: 'NPK Ratio',
              description: 'Essential nutrients for plant growth',
            ),
            _buildInfoTile(
              icon: Icons.balance_outlined,
              title: 'pH Level',
              description: 'Optimal pH range: 6.0-7.5',
            ),
            _buildInfoTile(
              icon: Icons.compost_outlined,
              title: 'Organic Matter',
              description: 'Improves soil structure and fertility',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMD),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingMD),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                ),
                child: Icon(icon, color: color, size: AppDimensions.iconLG),
              ),
              const SizedBox(width: AppDimensions.paddingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.bodyLarge),
                    Text(
                      description,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingMD),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: AppDimensions.paddingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyLarge),
                Text(
                  description,
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
