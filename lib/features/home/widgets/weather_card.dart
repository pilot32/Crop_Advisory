/// Weather Card Widget
///
/// Displays current weather information on home screen
/// Uses Riverpod providers for data — no manual setState

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/animated_page_route.dart';
import '../../weather/screens/weather_screen.dart';
//import '../../weather/providers/weather_provider.dart';
import '../../../providers/weather_provider.dart';
class WeatherCard extends ConsumerWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(currentWeatherProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => context.pushWithSlide(const WeatherScreen()),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF1E3A5F),
                    const Color(0xFF2E5F8F),
                  ]
                : [
                    AppColors.info,
                    AppColors.info.withOpacity(0.7),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.paddingLG),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
              ),
              // ── State handling ──────────────────────────
              child: weatherAsync.when(
                loading: () => _buildLoadingSkeleton(),
                error: (error, _) => _buildErrorState(error, ref),
                data: (weather) => _buildWeatherContent(context, weather),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Loading
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildLoadingSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 150,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1500.ms, color: Colors.white.withOpacity(0.5));
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Error
  // ─────────────────────────────────────────────────────────────────────────
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
            color: AppColors.textLight.withOpacity(0.7),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Weather Content — all variables from WeatherModel
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildWeatherContent(BuildContext context, dynamic weather) {
    // ── Extract ALL variables from the model ──
    final String location     = weather.location;
    final double temperature  = weather.temperature;
    final double feelsLike    = weather.feelsLike;
    final String condition    = weather.condition;
    final String? description = weather.description;
    final int humidity        = weather.humidity;
    final double windSpeed    = weather.windSpeed;
    final double rainfall     = weather.rainfall;
    final int uvIndex         = weather.uvIndex;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Top row: location + icon ──
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Weather',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textLight.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXS),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: AppColors.textLight,
                          size: AppDimensions.iconSM),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          location,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              _getWeatherIcon(condition),
              color: AppColors.textLight,
              size: 56,
            )
                .animate()
                .scale(duration: 800.ms, curve: Curves.elasticOut)
                .then()
                .shake(hz: 0.5, duration: 1000.ms),
          ],
        ),

        const SizedBox(height: AppDimensions.paddingLG),

        // ── Temperature + condition ──
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${temperature.toStringAsFixed(1)}°C',
                  style: AppTextStyles.h1.copyWith(
                    color: AppColors.textLight,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description ?? condition,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textLight.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Feels like ${feelsLike.toStringAsFixed(1)}°C',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textLight.withOpacity(0.7),
                  ),
                ),
              ],
            ),

            // ── Right-side detail chips ──
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildWeatherDetail(Icons.water_drop, '$humidity%'),
                const SizedBox(height: AppDimensions.paddingXS),
                _buildWeatherDetail(
                    Icons.air, '${windSpeed.toStringAsFixed(1)} m/s'),
                const SizedBox(height: AppDimensions.paddingXS),
                _buildWeatherDetail(
                    Icons.umbrella, '${rainfall} mm'),
                const SizedBox(height: AppDimensions.paddingXS),
                _buildWeatherDetail(Icons.wb_sunny, 'UV $uvIndex'),
              ],
            ),
          ],
        ),

        const SizedBox(height: AppDimensions.paddingMD),

        // ── Tap to view more ──
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.touch_app,
                  color: AppColors.textLight, size: 16),
              const SizedBox(width: 8),
              Text(
                'Tap for detailed forecast',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherDetail(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textLight, size: AppDimensions.iconSM),
          const SizedBox(width: 6),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
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