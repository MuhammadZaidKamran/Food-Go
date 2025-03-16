import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class FlutterNotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() async {
    await _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/launcher_icon"),
      ),
    );
    tz.initializeTimeZones();
  }

  static showNotification(
    String title,
    String body,
  ) async {
    var androidDetails = const AndroidNotificationDetails(
      "important_notification",
      "Important Notification",
      importance: Importance.max,
      priority: Priority.high,
    );
    var notificationDetails = NotificationDetails(
      android: androidDetails,
    );
    if (await Permission.scheduleExactAlarm.isGranted) {
      _notification.zonedSchedule(
        title.hashCode,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } else {
      debugPrint("Exact alarm permission not granted!");
    }
  }
}
