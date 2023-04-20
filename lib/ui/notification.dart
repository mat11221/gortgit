import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'utilities.dart';

Future<void> createReminderNotification(
    String title,
    String text,
    int id,
    String gort,
    String group,
    NotificationWeekAndTime notificationSchedule) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: id,
        channelKey: 'scheduled_channel',
        title: title,
        body: text,
        color: Colors.blue,
        notificationLayout: NotificationLayout.Default,
        payload: {'gort': gort},
        groupKey: group),
    actionButtons: [
      NotificationActionButton(key: 'DONE', label: 'Mark done'),
      NotificationActionButton(
          key: 'CANCEL',
          label: 'Cancel',
          actionType: ActionType.DismissAction,
          isDangerousOption: true)
    ],
    schedule: NotificationCalendar(
      weekday: notificationSchedule.dayOfTheWeek,
      hour: notificationSchedule.timeOfDay.hour,
      minute: notificationSchedule.timeOfDay.minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
}

Future<void> cancelScheduledNotifications(int uniq) async {
  await AwesomeNotifications().cancelSchedule(uniq);
}

Future<void> cancelAllGroupScheduledNotifications(String groupkey) async {
  await AwesomeNotifications().cancelSchedulesByGroupKey(groupkey);
}

Future<void> cancelAllNotifications(String groupkey) async {
  await AwesomeNotifications().cancelAll();
}
