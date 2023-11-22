import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('icono_notification');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNotification() async {const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
  'your_channel_id',
  'your_channel_name',
  channelDescription: 'Channel Description',
  importance: Importance.high,
  priority: Priority.high,
  
);


  const DarwinNotificationDetails darwinNotificationDetails =
      DarwinNotificationDetails();

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: darwinNotificationDetails,
  );

  await flutterLocalNotificationsPlugin.show(1, 'Nuevos Productos y Ofertas, ¡Compra Ya!',
      'Nuevos productos disponibles y más', notificationDetails);
}
