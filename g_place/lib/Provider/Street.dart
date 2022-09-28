import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Street with ChangeNotifier {
  late final String _place = 'Loading..';
  String get place => _place;

  String? _error;
  String? get error => _error;

  late final String _onTapPlace = 'No place select';
  String get onTapPlace => _onTapPlace;

  String? _subAdministrativeArea;
  String? get subAdministrativeArea => _subAdministrativeArea;

  String _liveLocation = 'My Location';
  String get liveLocation => _liveLocation;

  bool _connectionState = false;
  bool get connectionState => _connectionState;

  // Future<void> getStreet(LatLng latLng) async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

  //     _place = placemarks[0].street! +
  //         ',' +
  //         placemarks[0].locality! +
  //         ',' +
  //         placemarks[0].administrativeArea!;
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> getStreetOnTapChange(LatLng latLng) async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

  //     if (placemarks[0].subAdministrativeArea!.isNotEmpty) {
  //       _subAdministrativeArea = placemarks[0].subAdministrativeArea!;
  //       _error = null;
  //       notifyListeners();
  //     } else {
  //       _subAdministrativeArea = null;

  //       notifyListeners();
  //     }

  //     if (_subAdministrativeArea != null) {
  //       _onTapPlace = placemarks[0].street! +
  //           ',' +
  //           placemarks[0].locality! +
  //           ',' +
  //           placemarks[0].administrativeArea!;
  //       notifyListeners();
  //     } else {
  //       _onTapPlace = 'Invalid place';
  //       notifyListeners();
  //     }
  //   } on PlatformException catch (e) {
  //     _error = e.code;
  //     _subAdministrativeArea = null;
  //     _onTapPlace = 'Invalid place';

  //     notifyListeners();
  //   }
  // }

  Future<void> getPlaceMark(LatLng latLng) async {
    print(latLng);
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      Placemark placemark = placemarks.first;
      print(placemark);
      if (placemark.locality!.isNotEmpty &&
          placemark.subAdministrativeArea!.isNotEmpty &&
          placemark.subLocality!.isNotEmpty) {
        _liveLocation = placemark.subLocality.toString() +
            ", " +
            placemark.locality.toString() +
            ", " +
            placemark.subAdministrativeArea.toString();
      } else if (placemark.locality!.isNotEmpty &&
          placemark.subAdministrativeArea!.isNotEmpty &&
          placemark.thoroughfare!.isNotEmpty) {
        _liveLocation = placemark.thoroughfare.toString() +
            ", " +
            placemark.locality.toString() +
            ", " +
            placemark.subAdministrativeArea.toString();
      } else if (placemark.locality!.isNotEmpty &&
          placemark.subAdministrativeArea!.isNotEmpty) {
        _liveLocation = placemark.locality.toString() +
            ", " +
            placemark.subAdministrativeArea.toString();
      } else if (placemark.subLocality!.isNotEmpty &&
          placemark.subAdministrativeArea!.isNotEmpty &&
          placemark.name!.isNotEmpty) {
        _liveLocation = placemark.name.toString() +
            ", " +
            placemark.subLocality.toString() +
            ", " +
            placemark.subAdministrativeArea.toString();
      } else if (placemark.locality!.isEmpty) {
        _liveLocation = placemark.subAdministrativeArea.toString();
      }
      _connectionState = false;

      notifyListeners();
    } on PlatformException catch (e) {
      //No Internet Connection
      print('Error is :' + e.toString());
      if (e.code == 'IO_ERROR') {
        _connectionState = true;
      }
    } catch (e) {
      print('Second error is: ' + e.toString());
    }
  }
}
