import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_list/core/notification/localNorification.dart';

ThemeMode getTheme(String theme) {
  switch (theme) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.light;
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

listenToNotifications(BuildContext context) {
  LocalNotification.onClick.stream.listen((event) {
    Navigator.pushNamed(context, '/home');
  });
}

DateTime convertToDateTime(String time) {
  List<String> parts = time.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  // Using a fixed date, since we only care about time
  return DateTime(2000, 1, 1, hour, minute);
}
