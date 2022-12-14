// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print

import 'package:location/location.dart';
import 'package:ecommerce_user/common%20class/EngString.dart';

class location_permission {
  static const int ispermission = 0;
  parmission() async {
    Location location = Location();

    late bool _serviceEnabled;
    late PermissionStatus _permissionGranted;

    var response;
    LocationData? _locationData;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    // print(" accurecy =${_locationData.accuracy}");
    // print(" hasecode =${_locationData.hashCode}");
    // print(" altiru=${_locationData.altitude}");
    print("lati =${_locationData.latitude}");
    print("longoi=${_locationData.longitude}");

    Engstring.latitude = _locationData.latitude ?? 0.0;
    Engstring.longitude = _locationData.longitude ?? 0.0;
    Engstring.locationpermission = true;
  }
}
