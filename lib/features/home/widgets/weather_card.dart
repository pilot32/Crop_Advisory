/// Weather Card Widget
/// 
/// Displays current weather information on home screen

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../services/location_service.dart';
import '../../../services/weather_service.dart';
import '../../../core/utils/animated_page_route.dart';
import '../../weather/screens/weather_screen.dart';

class WeatherCard extends ConsumerStatefulWidget {
  const WeatherCard({super.key});

  @override
  ConsumerState<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends ConsumerState<WeatherCard> {
  String _location = 'Fetching...';
  double? _temperature;
  int? _humidity;
  double? _windSpeed;
  String? _condition;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final locationService = ref.read(locationServiceProvider);
      final weatherService = ref.read(weatherServiceProvider);

      // Get current position
      final position = await locationService.getCurrentPosition();

      // Get address
      final address = await locationService.getFormattedAddress(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      // Get weather
      final weather = await weatherService.getCurrentWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (mounted) {
        setState(() {
          _location = address;
          _temperature = weather.temperature;
          _humidity = weather.humidity;
          _windSpeed = weather.windSpeed;
          _condition = weather.condition;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _location = 'Location unavailable';
          _isLoading = false;
        });
      }
    }
  }

  IconData _getWeatherIcon(String? condition) {
    if (condition == null) return Icons.wb_sunny;
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.wb_cloudy;
      case 'rain':
        return Icons.umbrella;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      default:
        return Icons.wb_sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              child: _isLoading
                  ? _buildLoadingSkeleton()
                  : _buildWeatherContent(),
            ),
          ),
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

  Widget _buildWeatherContent() {
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
                      Icon(
                        Icons.location_on,
                        color: AppColors.textLight,
                        size: AppDimensions.iconSM,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          _location,
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
              _getWeatherIcon(_condition),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _temperature != null ? '${_temperature!.toStringAsFixed(1)}°C' : '--°C',
                  style: AppTextStyles.h1.copyWith(
                    color: AppColors.textLight,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _condition ?? 'Unknown',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textLight.withOpacity(0.9),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildWeatherDetail(
                  Icons.water_drop,
                  _humidity != null ? '$_humidity%' : '--%',
                ),
                const SizedBox(height: AppDimensions.paddingXS),
                _buildWeatherDetail(
                  Icons.air,
                  _windSpeed != null ? '${_windSpeed!.toStringAsFixed(1)} m/s' : '-- m/s',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingMD),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.touch_app,
                color: AppColors.textLight,
                size: 16,
              ),
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
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.textLight,
            size: AppDimensions.iconSM,
          ),
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
}
