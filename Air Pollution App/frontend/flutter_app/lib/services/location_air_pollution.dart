import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationAirPollution {
  final String baseUrl = "http://10.60.164.183:4000/api/airPollution";

  Future<Map<String, dynamic>> sendLocation(double lat, double lon) async {
    final url = Uri.parse("$baseUrl/location");

    final response = await http.post(
      url,
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
