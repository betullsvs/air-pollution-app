import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'notification_service.dart';

class PollingService {
  static const String apiUrl =
      'http://localhost:4000/api/airPollution/location';

  static Future<void> startPolling() async {
    Timer.periodic(const Duration(minutes: 10), (timer) async {
      try {
        final data = await fetchAirPollutionData();
        checkAirQuality(data);
      } catch (e) {
        print('Error fetching data: $e');
      }
    });
  }

  static Future<Map<String, dynamic>> fetchAirPollutionData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load air pollution data');
    }
  }

  static void checkAirQuality(Map<String, dynamic> data) {
  // Yanıt yapısına uygun olarak CO değerini al
  final co = data['list']?[0]?['components']?['co'];

  if (co != null && co > 250) {
    NotificationService.showNotification(
      title: 'Air Pollution Alert',
      body: 'CO level is above 250! (${co.toString()})',
    );
    print('Notification sent: CO level is ${co.toString()}');
  } else {
    print('CO level is below threshold: ${co?.toString() ?? "null"}');
  }
}

}
