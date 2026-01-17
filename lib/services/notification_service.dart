/// Notification Service
/// 
/// Handles push notifications for weather alerts, crop reminders, and farming tips

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
import 'dart:io' show Platform;

part 'notification_service.g.dart';

@Riverpod(keepAlive: true)
NotificationService notificationService(NotificationServiceRef ref) {
  return NotificationService();
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  final Logger _logger = Logger();
  bool _initialized = false;

  /// Initialize notification service
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      _logger.i('Initializing notification service');
      
      // Initialize timezone
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

      // Android initialization settings
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

      // iOS initialization settings
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _notifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      _initialized = true;
      _logger.i('Notification service initialized');
    } catch (e) {
      _logger.e('Error initializing notifications: $e');
    }
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    _logger.i('Notification tapped: ${response.payload}');
    // Handle navigation based on payload
  }

  /// Request notification permissions (mainly for iOS)
  Future<bool> requestPermissions() async {
    try {
      final result = await _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      
      final androidResult = await _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      return result ?? androidResult ?? false;
    } catch (e) {
      _logger.e('Error requesting permissions: $e');
      return false;
    }
  }

  /// Show immediate notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationPriority priority = NotificationPriority.defaultPriority,
  }) async {
    try {
      await initialize();

      const androidDetails = AndroidNotificationDetails(
        'crop_advisory_channel',
        'Crop Advisory',
        channelDescription: 'Farming tips and alerts',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(id, title, body, details, payload: payload);
      _logger.i('Notification shown: $title');
    } catch (e) {
      _logger.e('Error showing notification: $e');
    }
  }

  /// Schedule daily weather notification
  Future<void> scheduleDailyWeatherNotification({
    required int hour,
    required int minute,
  }) async {
    try {
      await initialize();

      const androidDetails = AndroidNotificationDetails(
        'weather_channel',
        'Daily Weather',
        channelDescription: 'Daily weather updates',
        importance: Importance.high,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails();

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.zonedSchedule(
        1, // ID for daily weather
        'Daily Weather Update',
        'Check today\'s weather forecast for your farm',
        _nextInstanceOfTime(hour, minute),
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      _logger.i('Daily weather notification scheduled at $hour:$minute');
    } catch (e) {
      _logger.e('Error scheduling weather notification: $e');
    }
  }

  /// Schedule crop activity reminder
  Future<void> scheduleCropReminder({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    try {
      await initialize();

      const androidDetails = AndroidNotificationDetails(
        'crop_reminders_channel',
        'Crop Reminders',
        channelDescription: 'Reminders for crop activities',
        importance: Importance.high,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails();

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );

      _logger.i('Crop reminder scheduled: $title at $scheduledDate');
    } catch (e) {
      _logger.e('Error scheduling crop reminder: $e');
    }
  }

  /// Schedule irrigation reminder
  Future<void> scheduleIrrigationReminder({
    required String cropName,
    required DateTime dateTime,
  }) async {
    await scheduleCropReminder(
      id: dateTime.millisecondsSinceEpoch ~/ 1000,
      title: '💧 Irrigation Reminder',
      body: 'Time to water your $cropName crop',
      scheduledDate: dateTime,
      payload: 'irrigation',
    );
  }

  /// Schedule fertilizer application reminder
  Future<void> scheduleFertilizerReminder({
    required String cropName,
    required String fertilizerType,
    required DateTime dateTime,
  }) async {
    await scheduleCropReminder(
      id: dateTime.millisecondsSinceEpoch ~/ 1000,
      title: '🌱 Fertilizer Application',
      body: 'Apply $fertilizerType to your $cropName crop',
      scheduledDate: dateTime,
      payload: 'fertilizer',
    );
  }

  /// Schedule harvest reminder
  Future<void> scheduleHarvestReminder({
    required String cropName,
    required DateTime dateTime,
  }) async {
    await scheduleCropReminder(
      id: dateTime.millisecondsSinceEpoch ~/ 1000,
      title: '🌾 Harvest Time!',
      body: 'Your $cropName is ready for harvest',
      scheduledDate: dateTime,
      payload: 'harvest',
    );
  }

  /// Schedule pest control reminder
  Future<void> schedulePestControlReminder({
    required String cropName,
    required DateTime dateTime,
  }) async {
    await scheduleCropReminder(
      id: dateTime.millisecondsSinceEpoch ~/ 1000,
      title: '🐛 Pest Control Reminder',
      body: 'Inspect and treat $cropName for pests',
      scheduledDate: dateTime,
      payload: 'pest_control',
    );
  }

  /// Cancel specific notification
  Future<void> cancelNotification(int id) async {
    try {
      await _notifications.cancel(id);
      _logger.i('Notification cancelled: $id');
    } catch (e) {
      _logger.e('Error cancelling notification: $e');
    }
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    try {
      await _notifications.cancelAll();
      _logger.i('All notifications cancelled');
    } catch (e) {
      _logger.e('Error cancelling all notifications: $e');
    }
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    try {
      return await _notifications.pendingNotificationRequests();
    } catch (e) {
      _logger.e('Error getting pending notifications: $e');
      return [];
    }
  }

  /// Helper: Calculate next instance of specific time
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  /// Send weather alert notification
  Future<void> sendWeatherAlert({
    required String alertType,
    required String message,
  }) async {
    await showNotification(
      id: 999,
      title: '⚠️ Weather Alert: $alertType',
      body: message,
      priority: NotificationPriority.max,
      payload: 'weather_alert',
    );
  }
}

enum NotificationPriority {
  min,
  low,
  defaultPriority,
  high,
  max,
}
