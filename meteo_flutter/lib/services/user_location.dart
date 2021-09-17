import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:location/location.dart';

class UserLoc {
  String city;
  String country;
  LocationData _locationData;
  PermissionStatus _permissionStatus;
  bool serviceEnabled;
  Location location = Location();

  Future<void> getLoc() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus == PermissionStatus.granted) {
        return null;
      }
    }
    _locationData = await location.getLocation();

    final coordinates =
        Coordinates(_locationData.latitude, _locationData.longitude);
    var adress = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print(adress.first.featureName);

    city = adress.first.featureName;
    country = adress.first.countryName;
  }
}
