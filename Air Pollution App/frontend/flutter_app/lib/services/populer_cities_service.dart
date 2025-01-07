import 'dart:convert';
import 'package:http/http.dart' as http;

class PopulerCitiesService {
  Future<Map<String, dynamic>> fetchAirPollution() async {
    final response = await http.get(Uri.parse(
        'http://192.168.13.246:4000/api/airPollution/populer-cities'));

    if (response.statusCode == 200) {
      var cityData = json.decode(response.body);

      var citiesData = {
        'Izmir': cityData['Izmir']['list'][0]['components'],
        'Ankara': cityData['Ankara']['list'][0]['components'],
        'Istanbul': cityData['Istanbul']['list'][0]['components'],
      };

      return citiesData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
