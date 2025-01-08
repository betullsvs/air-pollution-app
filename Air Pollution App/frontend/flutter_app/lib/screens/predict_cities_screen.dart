import 'package:flutter/material.dart';
import '../services/predict_cities_service.dart';

class PredictCitiesScreen extends StatefulWidget {
  const PredictCitiesScreen({super.key});

  @override
  State<PredictCitiesScreen> createState() => _PredictCitiesScreenState();
}

class _PredictCitiesScreenState extends State<PredictCitiesScreen> {
  final PredictCitiesService _service = PredictCitiesService();
  late Future<List<Map<String, dynamic>>> _cityDataFuture;

  @override
  void initState() {
    super.initState();
    _cityDataFuture = _service.getCityData("Istanbul");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/wallpaper1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "İstanbul Gelecek (10.01.25) Tahminleri",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _cityDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Hata: ${snapshot.error}"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("Veri bulunamadı."));
                      } else {
                        final data = snapshot.data!;
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return ListTile(
                              leading: const Icon(Icons.cloud),
                              title: Text("Saat: ${item['hour']}"),
                              subtitle: Text("PM2.5 Değeri: ${item['pm2_5']}"),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
