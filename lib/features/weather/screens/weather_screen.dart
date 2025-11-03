/// Weather Screen
/// 
/// Displays weather forecast and farming alerts

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change location coming soon')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Weather Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLG),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.wb_sunny,
                          size: 64,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: AppDimensions.paddingMD),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Current Location', style: AppTextStyles.h4),
                              Text(
                                '28°C',
                                style: AppTextStyles.h1.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                'Partly Cloudy',
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingMD),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildWeatherInfo(Icons.water_drop, '65%', 'Humidity'),
                        _buildWeatherInfo(Icons.air, '12 km/h', 'Wind'),
                        _buildWeatherInfo(Icons.umbrella, '20%', 'Rain'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLG),

            // Alerts
            Text('Weather Alerts', style: AppTextStyles.h4),
            const SizedBox(height: AppDimensions.paddingMD),
            _buildAlertCard(
              icon: Icons.warning_amber_rounded,
              title: 'Heavy Rain Expected',
              description: 'Prepare for heavy rainfall in next 3 days',
              color: AppColors.error,
            ),
            const SizedBox(height: AppDimensions.paddingLG),

            // 7-Day Forecast
            Text('7-Day Forecast', style: AppTextStyles.h4),
            const SizedBox(height: AppDimensions.paddingMD),
            ..._buildForecastList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: AppDimensions.paddingSM),
        Text(value, style: AppTextStyles.bodyLarge),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAlertCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: AppDimensions.paddingMD),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildForecastList() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days.map((day) {
      return Card(
        margin: const EdgeInsets.only(bottom: AppDimensions.paddingSM),
        child: ListTile(
          leading: Icon(Icons.wb_sunny, color: AppColors.accent),
          title: Text(day),
          subtitle: const Text('Partly Cloudy'),
          trailing: const Text('28°/22°'),
        ),
      );
    }).toList();
  }
}
