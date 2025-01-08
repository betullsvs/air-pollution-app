import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class LocationAirPollution {
  static const String url = '${ApiConfig.apiUrl}/location';

  Future<Map<String, dynamic>> sendLocation(double lat, double lon) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'lat': lat, 'lon': lon}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw 'API isteği başarısız oldu: ${response.statusCode}';
    }
  }
}
