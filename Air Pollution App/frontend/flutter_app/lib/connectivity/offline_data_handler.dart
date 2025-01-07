import 'package:flutter/material.dart';

class OfflineDataHandler extends StatelessWidget {
  const OfflineDataHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Çevrimdışı Mod: Yerel Veriler Gösteriliyor',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}