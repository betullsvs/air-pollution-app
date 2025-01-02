import 'package:flutter/material.dart';
import 'package:flutter_app/services/location_service.dart';
import 'package:flutter_app/services/location_city_service.dart';
import 'package:geolocator/geolocator.dart';

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

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _locationService.getCurrentLocation();
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });

      _getCityFromLocation();
    } catch (e) {
      print('Konum alınamadı: $e');
    }
  }

  Future<void> _getCityFromLocation() async {
    String city = await _locationCityService.getCityFromLocation();
    setState(() {
      _city = city;
    });
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
              // Enlem ve boylam bilgileri
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
              // Şehir bilgileri
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
