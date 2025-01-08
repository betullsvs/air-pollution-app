import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';  // Permission Handler import

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Bildirim servisini başlatmak
  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon'); // Uygulama simgesini belirtin

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);
  }

  // Bildirim izni istemek
  static Future<void> requestNotificationPermissions() async {
    // Bildirim izinlerini kontrol et
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      print("Bildirim izni verildi.");
    } else {
      print("Bildirim izni verilmedi.");
    }
  }

  // Bildirim göstermek
  static Future<void> showNotification(
      {required String title, required String body}) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}
