import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task_list/core/buildTask/task.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onClick = BehaviorSubject<String>();

  // Called when a notification is tapped
  static void onNotificationClick(NotificationResponse response) {
    if (response.payload != null) {
      onClick.add(response.payload!);
    }
  }

  // Initialize only for Android
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationClick,
      onDidReceiveBackgroundNotificationResponse: onNotificationClick,
    );
  }

  // Show simple notification
  static Future<void> showSimpleNot({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'simple_channel_id',
      'Simple Channel',
      channelDescription: 'Simple channel for notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // Show periodic notification
  static Future<void> showPeriodicNot({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'periodic_channel_id',
      'Periodic Channel',
      channelDescription: 'Repeating notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      title,
      body,
      RepeatInterval.everyMinute,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      payload: payload,
    );
  }

  // Cancel a specific notification
  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Cancel all notifications
  static Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> scheduleNotifications(List<Task> data) async {
  tz.initializeTimeZones();

  // ضبط المنطقة الزمنية المحلية على القاهرة
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
  final now = tz.TZDateTime.now(tz.local);

  await cancelAllNotification();

  data.sort((a, b) => DateTime.parse(a.time).compareTo(DateTime.parse(b.time)));

  for (Task task in data) {
    DateTime taskTime;
    try {
      taskTime = DateTime.parse(task.time);
    } catch (e) {
      debugPrint("Invalid task time format: ${task.time}");
      continue; // تخطي الوقت غير الصالح
    }

    final scheduledDate = tz.TZDateTime(
      tz.local,
      taskTime.year,
      taskTime.month,
      taskTime.day,
      taskTime.hour,
      taskTime.minute,
    );

    if (scheduledDate.isBefore(now)) continue;

    final timeUntilTask = scheduledDate.difference(now);
    String timeDescription;
    if (timeUntilTask.inHours > 0) {
      timeDescription = 'in ${timeUntilTask.inHours} hours';
    } else if (timeUntilTask.inMinutes > 0) {
      timeDescription = 'in ${timeUntilTask.inMinutes} minutes';
    } else {
      timeDescription = 'now';
    }

    debugPrint('Scheduling notification for task: ${timeDescription}');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      taskTime.millisecondsSinceEpoch ~/ 1000,
      'Upcoming Task: ${task.title}',
      'Task is scheduled $timeDescription\n${task.desc ?? ''}',
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminders',
          'Task Reminders',
          channelDescription: 'Reminders for your scheduled tasks',
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(''),
          enableVibration: true,
          playSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: task.title,
    );
  }
}


 static Future<void> scheduleNotificationForTask(Task task) async {
  
  debugPrint("Scheduling notification for task: ${task.title}");
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
  final location = tz.local;
  debugPrint('Scheduling notification Current timezone: ${location.name}');
  final now = tz.TZDateTime.now(tz.local);
  debugPrint("Scheduling notification Current time: $now");

  // Parse time string like "21 : 30"
  final timeParts = task.time.split(':');
  if (timeParts.length != 2) {
    debugPrint("Invalid time format: ${task.time}");
    return;
  }

  int hour;
  int minute;
  try {
    hour = int.parse(timeParts[0].trim());
    minute = int.parse(timeParts[1].trim());
  } catch (e) {
    debugPrint("Error parsing time: ${task.time}");
    return;
  }

  final scheduledDate = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    hour,
    minute,
  );

  debugPrint("Scheduling notification Scheduled date: $scheduledDate");

  if (scheduledDate.isBefore(now)) {
    debugPrint("Task time is in the past: ${task.title}");
    return;
  }

  final timeUntilTask = scheduledDate.difference(now);
  String timeDescription;
  if (timeUntilTask.inHours > 0) {
    timeDescription = 'in ${timeUntilTask.inHours} hours';
  } else if (timeUntilTask.inMinutes > 0) {
    timeDescription = 'in ${timeUntilTask.inMinutes} minutes';
  } else {
    timeDescription = 'now';
  }

  await flutterLocalNotificationsPlugin.zonedSchedule(
    task.id.hashCode,
    'Upcoming Task: ${task.title}',
    'Task is scheduled ${task.time}\n${task.desc}',
    scheduledDate,
    NotificationDetails(
      android: AndroidNotificationDetails(
        
        'task_reminders',
        'Task Reminders',
        channelDescription: 'Reminders for your scheduled tasks',
        importance: Importance.high,
        priority: Priority.high,
        styleInformation: BigTextStyleInformation(''),
        enableVibration: true,
        playSound: true,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    payload: task.title,
  );
  debugPrint("Notification scheduled for task: ${task.title} at $scheduledDate");
}


}
