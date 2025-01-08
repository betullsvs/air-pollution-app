import 'notification_service.dart';
import 'polling_service.dart';

class NotificationManager {
  static Future<void> initialize() async {
    await NotificationService.initialize();
    PollingService.startPolling();
  }
}
