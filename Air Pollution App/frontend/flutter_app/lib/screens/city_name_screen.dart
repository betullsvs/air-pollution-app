import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Tarih formatlama kütüphanesi

import '../services/city_name_service.dart';
import 'city_graphic_screen.dart';
import 'user_home_screen.dart';

class CityNameScreen extends StatefulWidget {
  const CityNameScreen({super.key});

  @override
  _CityNameScreenState createState() => _CityNameScreenState();
}

class _CityNameScreenState extends State<CityNameScreen> {
  final TextEditingController _cityController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  int _selectedIndex = 1;
  bool _showGraphic = true;
  List<Map<String, dynamic>> _cityData = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserHomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CityNameScreen()),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  Future<void> _submitData() async {
    final cityName = _cityController.text.trim();

    if (cityName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen bir şehir adı girin.")),
      );
      return;
    }

    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Lütfen başlangıç ve bitiş tarihlerini seçin.")),
      );
      return;
    }

    if (_startDate!.isAfter(_endDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Başlangıç tarihi bitiş tarihinden önce olmalıdır.")),
      );
      return;
    }

    CityNameService cityService = CityNameService();

    try {
      List<Map<String, dynamic>> cityData =
          await cityService.getCityData(cityName, _startDate!, _endDate!);
      print("API'den gelen veri: $cityData");
      setState(() {
        _cityData = cityData;
        _showGraphic = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veriler alınamadı.")),
      );
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Şehir ve Tarih Seçimi",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Hava kalitesi verilerini görmek istediğiniz şehri ve tarih aralıklarını girin.",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: "Şehir Adı",
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 9, 68, 107)),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _startDate == null
                              ? "Başlangıç Tarihi Seç"
                              : "Başlangıç Tarihi: ${DateFormat('yyyy-MM-dd').format(_startDate!)}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today,
                              color: Colors.white),
                          onPressed: () => _selectDate(context, true),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _endDate == null
                              ? "Bitiş Tarihi Seç"
                              : "Bitiş Tarihi: ${DateFormat('yyyy-MM-dd').format(_endDate!)}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today,
                              color: Colors.white),
                          onPressed: () => _selectDate(context, false),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitData,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("BUL",
                        style: TextStyle(fontSize: 18, color: Colors.purple)),
                  ),
                  if (_showGraphic) ...[
                    const SizedBox(height: 20),
                    Expanded(
                      child: CityGraphic(data: _cityData),
                    ),
                  ],
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
