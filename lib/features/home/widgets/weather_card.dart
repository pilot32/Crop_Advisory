/// Weather Card Widget
/// 
/// Displays current weather information on home screen

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Connect to weather provider
    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.info,
              AppColors.info.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        ),
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Location',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textLight.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingXS),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.textLight,
                          size: AppDimensions.iconSM,
                        ),
                        const SizedBox(width: AppDimensions.paddingXS),
                        Text(
                          'Fetching...',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(
                  Icons.wb_sunny,
                  color: AppColors.textLight,
                  size: AppDimensions.iconXL,
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMD),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '-- °C',
                  style: AppTextStyles.h1.copyWith(
                    color: AppColors.textLight,
                    fontSize: 42,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildWeatherDetail(Icons.water_drop, '-- %'),
                    const SizedBox(height: AppDimensions.paddingXS),
                    _buildWeatherDetail(Icons.air, '-- km/h'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingSM),
            Text(
              'Tap for detailed forecast',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textLight.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.textLight,
          size: AppDimensions.iconSM,
        ),
        const SizedBox(width: AppDimensions.paddingXS),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textLight,
          ),
        ),
      ],
    );
  }
}
