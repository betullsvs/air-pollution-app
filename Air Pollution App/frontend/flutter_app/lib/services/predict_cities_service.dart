import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class PredictCitiesService {
  final String apiUrl = '${ApiConfig.apiUrl}/haurly';

  Future<List<Map<String, dynamic>>> getCityData(String cityName) async {
    final DateTime startDate = DateTime(2025, 1, 10);
    final DateTime endDate = DateTime(2025, 1, 11);

    final Map<String, dynamic> data = {
      'cityName': cityName,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        List<Map<String, dynamic>> formattedData = [];
        for (var item in jsonResponse['list']) {
          int timestamp = item['dt'];
          double pm2_5 = item['components']['pm2_5'];

          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
          int hour = dateTime.hour;

          formattedData.add({
            'hour': hour,
            'pm2_5': pm2_5,
          });
        }

        return formattedData;
      } else {
        throw Exception('Failed to load city data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load city data');
    }
  }
}
