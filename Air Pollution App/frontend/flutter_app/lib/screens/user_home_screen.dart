import 'package:flutter/material.dart';
import 'package:flutter_app/screens/city_name_screen.dart';
import 'package:flutter_app/screens/populer_cities_screen.dart';
import 'package:flutter_app/widgets/air_quality_table.dart';
import 'package:flutter_app/services/location_service.dart';
import 'package:flutter_app/services/location_city_service.dart';
import 'package:flutter_app/services/location_air_pollution.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/entry_button.dart';
import '../widgets/user_location.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final LocationService _locationService = LocationService();
  final LocationCityService _locationCityService = LocationCityService();
  final LocationAirPollution _airPollutionService = LocationAirPollution();

  double? _latitude;
  double? _longitude;
  String _city = "Şehir bilgisi alınıyor...";
  Map<String, dynamic>? _components;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserHomeScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CityNameScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _locationService.getCurrentLocation();
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });

      await _getCityFromLocation();
      await _getAirQuality();
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

  Future<void> _getAirQuality() async {
    if (_latitude != null && _longitude != null) {
      try {
        Map<String, dynamic> response = await _airPollutionService.sendLocation(
          _latitude!,
          _longitude!,
        );
        setState(() {
          _components = response['list'][0]['components'];
        });
      } catch (e) {
        print('Hava kalitesi alınamadı: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/wallpaper1.jpg',
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "HOŞ GELDİNİZ",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          "Bulunduğunuz Şehrin Bilgileri",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserLocation(
                      latitude: _latitude,
                      longitude: _longitude,
                      city: _city,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _components == null
                        ? Text(
                            "Hava kalitesi bilgisi alınıyor...",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          )
                        : AirQualityTable(components: _components!),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: EntryButton(
                        buttonText: "Popüler Şehirleri Gör",
                        pageRoute: PopulerCitiesScreen(),
                        backgroundColor: Color.fromARGB(255, 135, 201, 255)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: EntryButton(
                        buttonText: "Kirlilik Tahmini Gör",
                        pageRoute: PopulerCitiesScreen(),
                        backgroundColor: Color.fromARGB(255, 135, 201, 255)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Anasayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Bul",
          ),
        ],
      ),
    );
  }
}
