import 'package:geocoding/geocoding.dart';
import 'package:grumbler/models/address_item.dart';

abstract class IGeocodingRepository {
  Future<AddressItem?> fromCoordinates(double latitude, double longitude);
}

class GoogleGeoCodingRepository implements IGeocodingRepository {
  @override
  Future<AddressItem?> fromCoordinates(
      double latitude, double longitude) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        latitude, longitude,
        localeIdentifier: "tr_TR");

    if (placeMarks.isNotEmpty) {
      return  AddressItem(
          province: placeMarks.first.administrativeArea ?? "Bilinmiyor",
          country:   placeMarks.first.country ?? "Bilinmiyor",
          district: placeMarks.first.subAdministrativeArea ?? "",
          latitude: latitude,
          longitude: longitude,
          street: placeMarks.first.thoroughfare ?? "",
          town: placeMarks.first.subLocality);
    } else {
      return null;
    }
  }
}
