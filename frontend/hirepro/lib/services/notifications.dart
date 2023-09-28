import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class Notifications {

       FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();
  static Future initializeNotification(
     ) async {
       final FlutterLocalNotificationsPlugin notification =
      FlutterLocalNotificationsPlugin();
    var androidInitialize = const AndroidInitializationSettings('hirepro_logo');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    await notification.initialize(initializationSettings);
  }

   Future showNotification(
      {int id = 0,
      required String title,
      required String body,
      var payload,
    }) async {
    notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'HirePro_1',
      'HireProChannel',
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
      
    );
    var notification =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await notificationPlugin.show(0, title, body, notification);
    
  }

  
}
