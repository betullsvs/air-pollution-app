import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';

class LocationCityService {
  final LocationService _locationService = LocationService();

  Future<String> getCityFromLocation() async {
    try {
      Position position = await _locationService.getCurrentLocation();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];

        String city = placemark.locality?.isNotEmpty == true
            ? placemark.locality!
            : placemark.administrativeArea ?? "Bilinmeyen Şehir";

        String district = placemark.subAdministrativeArea ?? "Bilinmeyen İlçe";

        return "$city, $district";
      } else {
        return "Şehir ve İlçe bilgisi bulunamadı.";
      }
    } catch (e) {
      return 'Konum alınamadı: $e';
    }
  }
}
