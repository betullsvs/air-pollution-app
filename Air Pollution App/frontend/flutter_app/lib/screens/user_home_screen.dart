import 'dart:convert';  // JSON parsing için gerekli
import 'package:flutter/material.dart';
import 'package:flutter_app/services/location_service.dart';
import 'package:flutter_app/services/location_city_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_app/notification/notification_service.dart';  // Bildirim servisini import et
import 'package:http/http.dart' as http;  // HTTP isteği için import et

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final LocationService _locationService = LocationService();
  final LocationCityService _locationCityService = LocationCityService();
  double? _latitude;
  double? _longitude;
  String _city = "Şehir bilgisi alınıyor...";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Konum bilgisi 
    _getCityFromLocation(); // Şehir bilgisi
  }

  // Konum bilgisini almak
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _locationService.getCurrentLocation();
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });

      // Şehir bilgisini al
      _getCityFromLocation();

      // API'ye POST isteği gönder
      await _getAirPollutionData(_latitude!, _longitude!);
    } catch (e) {
      print('Konum alınamadı: $e');
    }
  }

  // Şehir bilgisini almak
  Future<void> _getCityFromLocation() async {
    String city = await _locationCityService.getCityFromLocation();
    setState(() {
      _city = city;
    });
  }

  // API'ye POST isteği gönderip, CO değerini kontrol et
  Future<void> _getAirPollutionData(double lat, double lon) async {
    const String url = 'http://192.168.8.205:4000/api/airPollution/location';
    
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'lat': lat, 'lon': lon}),
    );

    if (response.statusCode == 200) {
      // API cevabını parse et
      final data = json.decode(response.body);
      final co = data['list'][0]['components']['co'];

      // Eğer CO değeri 50'den büyükse bildirim gönder
      if (co > 50) {
        await Future.delayed(const Duration(seconds: 5));
        NotificationService.showNotification(
          title: "Hava Kirliliği Uyarısı",
          body: "CO seviyesi yüksek! Şu anki CO seviyesi: $co",
        );
      }
    } else {
      print('API isteği başarısız: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "HOŞ GELDİNİZ",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Enlem ve boylam bilgilerini göstermek
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _latitude != null && _longitude != null
                      ? "Enlem: $_latitude, Boylam: $_longitude"
                      : "Konum bilgisi alınıyor...",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ),
              // Şehir bilgisini göstermek
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Şehir: $_city",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
