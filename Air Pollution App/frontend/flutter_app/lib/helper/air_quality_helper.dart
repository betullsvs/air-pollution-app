import 'package:flutter/material.dart';

class AirQualityHelper {
  static Map<String, dynamic> getColorAndDescription(
      String component, double value) {
    switch (component) {
      case 'pm10':
        return _getPM10ColorAndDescription(value);
      case 'no':
        return _getNOColorAndDescription(value);
      case 'pm2_5':
        return _getPM25ColorAndDescription(value);
      case 'no2':
        return _getNO2ColorAndDescription(value);
      case 'o3':
        return _getO3ColorAndDescription(value);
      case 'co':
        return _getCOColorAndDescription(value);
      case 'so2':
        return _getSO2ColorAndDescription(value);
      case 'nh3':
        return _getNH3ColorAndDescription(value);
      default:
        return {'color': Colors.grey, 'description': 'Bilinmiyor'};
    }
  }

  // PM10
  static Map<String, dynamic> _getPM10ColorAndDescription(double value) {
    if (value <= 50) return {'color': Colors.green, 'description': 'İyi'};
    if (value <= 100) {
      return {'color': Colors.lightGreen, 'description': 'Tatmin Edici'};
    }
    if (value <= 250) return {'color': Colors.yellow, 'description': 'Orta'};
    if (value <= 350) return {'color': Colors.orange, 'description': 'Kötü'};
    if (value <= 430) return {'color': Colors.red, 'description': 'Çok Kötü'};
    return {'color': Colors.purple, 'description': 'Şiddetli'};
  }

  // NO
  static Map<String, dynamic> _getNOColorAndDescription(double value) {
    if (value <= 0.00833) return {'color': Colors.green, 'description': 'İyi'};
    if (value <= 0.01667) {
      return {'color': Colors.lightGreen, 'description': 'Tatmin Edici'};
    }
    if (value <= 0.025) return {'color': Colors.yellow, 'description': 'Orta'};
    if (value <= 0.03333) {
      return {'color': Colors.orange, 'description': 'Kötü'};
    }
    if (value <= 0.04167) {
      return {'color': Colors.red, 'description': 'Çok Kötü'};
    }
    return {'color': Colors.purple, 'description': 'Şiddetli'};
  }

  // PM2.5
  static Map<String, dynamic> _getPM25ColorAndDescription(double value) {
    if (value <= 30) return {'color': Colors.green, 'description': 'İyi'};
    if (value <= 60) {
      return {'color': Colors.lightGreen, 'description': 'Tatmin Edici'};
    }
    if (value <= 90) return {'color': Colors.yellow, 'description': 'Orta'};
    if (value <= 120) return {'color': Colors.orange, 'description': 'Kötü'};
    if (value <= 250) return {'color': Colors.red, 'description': 'Çok Kötü'};
    return {'color': Colors.purple, 'description': 'Şiddetli'};
  }

  // NO2
  static Map<String, dynamic> _getNO2ColorAndDescription(double value) {
    if (value <= 40) return {'color': Colors.green, 'description': 'İyi'};
    if (value <= 80) {
      return {'color': Colors.lightGreen, 'description': 'Tatmin Edici'};
    }
    if (value <= 180) return {'color': Colors.yellow, 'description': 'Orta'};
    if (value <= 280) return {'color': Colors.orange, 'description': 'Kötü'};
    if (value <= 400) return {'color': Colors.red, 'description': 'Çok Kötü'};
    return {'color': Colors.purple, 'description': 'Şiddetli'};
  }

  // O3
  static Map<String, dynamic> _getO3ColorAndDescription(double value) {
    if (value <= 50) return {'color': Colors.green, 'description': 'İyi'};
    if (value <= 100) {
      return {'color': Colors.lightGreen, 'description': 'Tatmin Edici'};
    }
    if (value <= 168) return {'color': Colors.yellow, 'description': 'Orta'};
    if (value <= 208) return {'color': Colors.orange, 'description': 'Kötü'};
    if (value <= 748) return {'color': Colors.red, 'description': 'Çok Kötü'};
    return {'color': Colors.purple, 'description': 'Şiddetli'};
  }

  // CO
  static Map<String, dynamic> _getCOColorAndDescription(double value) {
    if (value <= 1.0) return {'color': Colors.green, 'description': 'İyi'};
    if (value <= 2.0) {
      return {'color': Colors.lightGreen, 'description': 'Tatmin Edici'};
    }
    if (value <= 10.0) return {'color': Colors.yellow, 'description': 'Orta'};
    if (value <= 17.0) return {'color': Colors.orange, 'description': 'Kötü'};
    if (value <= 34.0) return {'color': Colors.red, 'description': 'Çok Kötü'};
    return {'color': Colors.purple, 'description': 'Şiddetli'};
  }

  // SO2
  static Map<String, dynamic> _getSO2ColorAndDescription(double value) {
    if (value <= 40) return {'color': Colors.green, 'description': 'İyi'};
    if (value <= 80) {
      return {'color': Colors.lightGreen, 'description': 'Tatmin Edici'};
    }
    if (value <= 380) return {'color': Colors.yellow, 'description': 'Orta'};
    if (value <= 800) return {'color': Colors.orange, 'description': 'Kötü'};
    if (value <= 1600) return {'color': Colors.red, 'description': 'Çok Kötü'};
    return {'color': Colors.purple, 'description': 'Şiddetli'};
  }

  // NH3
  static Map<String, dynamic> _getNH3ColorAndDescription(double value) {
    if (value <= 200) return {'color': Colors.green, 'description': 'İyi'};
    if (value <= 400) {
      return {'color': Colors.lightGreen, 'description': 'Tatmin Edici'};
    }
    if (value <= 800) return {'color': Colors.yellow, 'description': 'Orta'};
    if (value <= 1200) return {'color': Colors.orange, 'description': 'Kötü'};
    if (value <= 1800) return {'color': Colors.red, 'description': 'Çok Kötü'};
    return {'color': Colors.purple, 'description': 'Şiddetli'};
  }
}
