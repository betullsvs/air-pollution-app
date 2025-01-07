import 'package:flutter/material.dart';

class UserLocation extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  final String city;

  const UserLocation({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 350,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue[900]!,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              latitude != null && longitude != null
                  ? "Enlem: $latitude\nBoylam: $longitude"
                  : "Konum bilgisi alınıyor...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Şehir: $city",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
