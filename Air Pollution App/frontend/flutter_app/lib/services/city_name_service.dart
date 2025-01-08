import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class CityNameService {
  final String apiUrl = '${ApiConfig.apiUrl}/haurly';

  Future<List<Map<String, dynamic>>> getCityData(
      String cityName, DateTime startDate, DateTime endDate) async {
    final startLocalDate =
        DateTime(startDate.year, startDate.month, startDate.day)
            .toIso8601String()
            .split('T')[0];
    final endLocalDate = DateTime(endDate.year, endDate.month, endDate.day)
        .toIso8601String()
        .split('T')[0];

    final Map<String, dynamic> data = {
      'cityName': cityName,
      'startDate': startLocalDate,
      'endDate': endLocalDate,
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
          double co = item['components']['co'];

          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
          int hour = dateTime.hour;

          formattedData.add({
            'hour': hour,
            'co': co,
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
