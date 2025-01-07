import 'package:flutter/material.dart';
import 'package:flutter_app/services/populer_cities_service.dart';
import '../widgets/air_quality_table.dart';

class PopulerCitiesScreen extends StatefulWidget {
  const PopulerCitiesScreen({super.key});

  @override
  State<PopulerCitiesScreen> createState() => _PopulerCitiesScreen();
}

class _PopulerCitiesScreen extends State<PopulerCitiesScreen> {
  Map<String, dynamic>? _izmirData;
  Map<String, dynamic>? _ankaraData;
  Map<String, dynamic>? _istanbulData;
  final PopulerCitiesService _populerCitiesService = PopulerCitiesService();

  @override
  void initState() {
    super.initState();
    fetchAirPollutionData();
  }

  Future<void> fetchAirPollutionData() async {
    try {
      var citiesData = await _populerCitiesService.fetchAirPollution();
      setState(() {
        _izmirData = citiesData['Izmir'];
        _ankaraData = citiesData['Ankara'];
        _istanbulData = citiesData['Istanbul'];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/wallpaper1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          _izmirData == null || _ankaraData == null || _istanbulData == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 44),
                      const Text(
                        "İZMİR",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      AirQualityTable(components: _izmirData!),
                      const SizedBox(height: 44),
                      const Text(
                        "ANKARA",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      AirQualityTable(components: _ankaraData!),
                      const SizedBox(height: 44),
                      const Text(
                        "İSTANBUL",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      AirQualityTable(components: _istanbulData!),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
