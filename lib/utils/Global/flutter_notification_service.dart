import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class FlutterNotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() async {
    await _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
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

    _notification.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
