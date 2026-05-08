/// Weather Card Widget
///
/// Displays current weather information with animations and error handling

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/weather_provider.dart';

class WeatherCard extends ConsumerWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(currentWeatherProvider);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLG),
              child: weatherAsync.when(
                loading: () => _buildLoadingSkeleton(),
                error: (error, _) => _buildErrorState(error, ref),
                data: (weather) => _buildWeatherContent(context, weather),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 150,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1500.ms, color: Colors.white.withValues(alpha: 0.5));
  }

  Widget _buildErrorState(Object error, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.error_outline,
                color: AppColors.textLight, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Weather unavailable',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh, color: AppColors.textLight),
              onPressed: () =>
                  ref.read(currentWeatherProvider.notifier).refresh(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          error.toString(),
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textLight.withValues(alpha: 0.7),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildWeatherContent(BuildContext context, dynamic weather) {
    final String location = weather.location;
    final double temperature = weather.temperature;
    final double feelsLike = weather.feelsLike;
    final String condition = weather.condition;
    final String? description = weather.description;
    final int humidity = weather.humidity;
    final double windSpeed = weather.windSpeed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: AppColors.textLight,
                          size: AppDimensions.iconSM),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          location,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textLight,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description ?? condition,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textLight.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              _getWeatherIcon(condition),
              color: AppColors.textLight,
              size: 48,
            )
                .animate()
                .scale(duration: 800.ms, curve: Curves.elasticOut)
                .then()
                .shake(hz: 0.5, duration: 1000.ms),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingLG),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${temperature.toStringAsFixed(1)}°',
                  style: AppTextStyles.h1.copyWith(
                    color: AppColors.textLight,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
                Text(
                  'Feels like ${feelsLike.toStringAsFixed(1)}°',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textLight.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                _buildWeatherDetail(Icons.water_drop, '$humidity%'),
                const SizedBox(width: AppDimensions.paddingSM),
                _buildWeatherDetail(
                    Icons.air, '${windSpeed.toStringAsFixed(1)}m/s'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeatherDetail(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textLight, size: 14),
          const SizedBox(width: 4),
          Text(
            value,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.wb_cloudy;
      case 'rain':
      case 'drizzle':
        return Icons.umbrella;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'fog':
      case 'haze':
        return Icons.cloud_queue;
      default:
        return Icons.wb_sunny;
    }
  }
}
