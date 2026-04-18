/// Weather Screen
///
/// Displays weather forecast and farming alerts with real API data

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
//import '../../providers/weather_provider.dart';
import '../../../providers/weather_provider.dart';
import '../../../models/weather_model.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(currentWeatherProvider);
    final forecastAsync = ref.watch(weatherForecastNotifierProvider);
    final alerts = ref.watch(weatherAlertsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              ref.read(currentWeatherProvider.notifier).refresh();
              ref.read(weatherForecastNotifierProvider.notifier).refresh();
            },
          ),
          IconButton(
            icon: const Icon(Icons.location_on_outlined),
            tooltip: 'Change location',
            onPressed: () => _showCitySearchDialog(context, ref),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            ref.read(currentWeatherProvider.notifier).refresh(),
            ref.read(weatherForecastNotifierProvider.notifier).refresh(),
          ]);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppDimensions.paddingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Current Weather ---
              weatherAsync.when(
                loading: () => const _WeatherCardSkeleton(),
                error: (error, stack) => _ErrorCard(
                  message: error.toString(),
                  onRetry: () =>
                      ref.read(currentWeatherProvider.notifier).refresh(),
                ),
                data: (weather) => _CurrentWeatherCard(weather: weather),
              ),

              const SizedBox(height: AppDimensions.paddingLG),

              // --- Weather Alerts ---
              if (alerts.isNotEmpty) ...[
                Text('Weather Alerts', style: AppTextStyles.h4),
                const SizedBox(height: AppDimensions.paddingSM),
                ...alerts.map(
                  (alert) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDimensions.paddingSM,
                    ),
                    child: _AlertCard(alert: alert),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingLG),
              ],

              // --- Forecast ---
              Text('5-Day Forecast', style: AppTextStyles.h4),
              const SizedBox(height: AppDimensions.paddingSM),
              forecastAsync.when(
                loading: () => const _ForecastSkeleton(),
                error: (error, stack) => _ErrorCard(
                  message: error.toString(),
                  onRetry: () => ref
                      .read(weatherForecastNotifierProvider.notifier)
                      .refresh(),
                ),
                data: (forecast) => _ForecastList(forecast: forecast),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCitySearchDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Search City'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter city name',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              ref
                  .read(currentWeatherProvider.notifier)
                  .fetchByCity(value.trim());
              Navigator.pop(ctx);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                ref
                    .read(currentWeatherProvider.notifier)
                    .fetchByCity(controller.text.trim());
                Navigator.pop(ctx);
              }
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-Widgets
// ─────────────────────────────────────────────────────────────────────────────

class _CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;
  const _CurrentWeatherCard({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          children: [
            Row(
              children: [
                _WeatherIcon(condition: weather.condition, size: 64),
                const SizedBox(width: AppDimensions.paddingMD),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(weather.location, style: AppTextStyles.h4),
                      Text(
                        '${weather.temperature.toStringAsFixed(1)}°C',
                        style: AppTextStyles.h1.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        weather.description ?? weather.condition,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Feels like ${weather.feelsLike.toStringAsFixed(1)}°C',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMD),
            const Divider(),
            const SizedBox(height: AppDimensions.paddingSM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _WeatherInfoTile(
                  icon: Icons.water_drop,
                  value: '${weather.humidity}%',
                  label: 'Humidity',
                ),
                _WeatherInfoTile(
                  icon: Icons.air,
                  value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
                  label: 'Wind',
                ),
                _WeatherInfoTile(
                  icon: Icons.umbrella,
                  value: '${weather.rainfall} mm',
                  label: 'Rain',
                ),
                _WeatherInfoTile(
                  icon: Icons.wb_sunny,
                  value: '${weather.uvIndex}',
                  label: 'UV Index',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherInfoTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _WeatherInfoTile({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: AppDimensions.paddingSM),
        Text(value, style: AppTextStyles.bodyLarge),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  final String condition;
  final double size;
  const _WeatherIcon({required this.condition, this.size = 48});

  @override
  Widget build(BuildContext context) {
    final iconData = _getIconForCondition(condition);
    return Icon(iconData, size: size, color: AppColors.accent);
  }

  IconData _getIconForCondition(String condition) {
    final c = condition.toLowerCase();
    if (c.contains('cloud')) return Icons.cloud;
    if (c.contains('rain') || c.contains('drizzle')) return Icons.water_drop;
    if (c.contains('thunder') || c.contains('storm')) return Icons.flash_on;
    if (c.contains('snow')) return Icons.ac_unit;
    if (c.contains('mist') || c.contains('fog') || c.contains('haze')) {
      return Icons.cloud_queue;
    }
    if (c.contains('clear')) return Icons.wb_sunny;
    return Icons.wb_sunny;
  }
}

class _AlertCard extends StatelessWidget {
  final WeatherAlert alert;
  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    final color = _severityColor(alert.severity);
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber_rounded, color: color),
            const SizedBox(width: AppDimensions.paddingMD),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          alert.title,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          alert.severity.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(alert.description, style: AppTextStyles.caption),
                  const SizedBox(height: 4),
                  Text(
                    '${_formatDate(alert.startTime)} — ${_formatDate(alert.endTime)}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _severityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'medium':
        return Colors.amber;
      case 'low':
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _ForecastList extends StatelessWidget {
  final WeatherForecast forecast;
  const _ForecastList({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: forecast.daily.map((day) {
        return Card(
          margin: const EdgeInsets.only(bottom: AppDimensions.paddingSM),
          child: ListTile(
            leading: _WeatherIcon(condition: day.condition, size: 32),
            title: Text(_formatDay(day.date)),
            subtitle: Text(day.condition),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${day.maxTemp.toStringAsFixed(0)}°',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${day.minTemp.toStringAsFixed(0)}°',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _formatDay(DateTime date) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Loading & Error States
// ─────────────────────────────────────────────────────────────────────────────

class _WeatherCardSkeleton extends StatelessWidget {
  const _WeatherCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 64,
                  height: 64,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: AppDimensions.paddingMD),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Container(width: 80, height: 32, color: Colors.grey[300]),
                      const SizedBox(height: 4),
                      Container(
                        width: 160,
                        height: 14,
                        color: Colors.grey[200],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ForecastSkeleton extends StatelessWidget {
  const _ForecastSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (_) {
        return Card(
          margin: const EdgeInsets.only(bottom: AppDimensions.paddingSM),
          child: const ListTile(
            leading: SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            title: SizedBox(
              width: 60,
              height: 14,
              child: LinearProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorCard({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.error.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 40),
            const SizedBox(height: AppDimensions.paddingSM),
            Text(
              'Failed to load weather',
              style: AppTextStyles.h4.copyWith(color: AppColors.error),
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppDimensions.paddingMD),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
