import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_place/Provider/Street.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleService with ChangeNotifier {
  Completer<GoogleMapController> get complete => _complete;
  late Completer<GoogleMapController> _complete;

  late CameraPosition _cameraPosition =
      CameraPosition(target: _locationPosition);
  CameraPosition get cameraPosition => _cameraPosition;

  Street street = Street();
  String get name => street.place;
  String get onTapPlace => street.onTapPlace;

  late Location _location;
  Location get location => _location;

  late LatLng _locationPosition;
  LatLng get locationPosition => _locationPosition;

  bool _locationServiceActive = false;
  bool get locationSreviceActive => _locationServiceActive;

  late final Marker _marker =
      Marker(markerId: const MarkerId('value'), position: _locationPosition);
  Marker get marker => _marker;

  String get liveLocation => street.liveLocation;

  String _greating = 'Nice Day';
  String get greating => _greating;

  bool _dragState = false;
  bool get dragState => _dragState;

  GoogleService() {
    _location = Location();
  }
  initalization() async {
    _complete = Completer();

    await getUserLocation();
    getTime();
  }

  getUserLocation() async {
    bool _serviseEnabled;
    PermissionStatus _permissionGranted;

    try {
      _serviseEnabled = await location.serviceEnabled();
      if (!_serviseEnabled) {
        _serviseEnabled = await location.requestService();
        if (!_serviseEnabled) {
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

      location.onLocationChanged.listen((LocationData curentLocation) {
        _locationPosition =
            LatLng(curentLocation.latitude!, curentLocation.longitude!);
        // getCurentMapCamera(_locationPosition);
        //street.getStreet(_locationPosition);
        _locationServiceActive = true;

        notifyListeners();
      });
    } on MissingPluginException catch (e) {
      print(e);
    }
  }

  Future<void> getCurentMapCamera(LatLng latLng) async {
    print(latLng);
    try {
      GoogleMapController controller = await _complete.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(zoom: 16.5, target: latLng)));
      controller.dispose();
    } on MissingPluginException catch (e) {
      print(e);
    }
  }

  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
  //       .buffer
  //       .asUint8List();
  // }

  // Future<void> setMarker(LatLng latLng) async {
  //   final Uint8List markerIcon =
  //       await getBytesFromAsset('assets/women.png', 50);

  //   try {
  //     print(latLng);
  //     await street.getStreetOnTapChange(latLng);
  //     print(street.subAdministrativeArea);
  //     print(street.error);

  //     if (street.subAdministrativeArea != null && street.error != 'NOT_FOUND') {
  //       _marker = Marker(
  //           onDrag: (value) async {
  //             await street.getStreetOnTapChange(value);
  //           },
  //           onDragStart: (value) {},
  //           draggable: false,
  //           flat: true,
  //           // onDragStart: (value) async {
  //           //   await street.getStreetOnTapChange(value);
  //           // },
  //           icon: BitmapDescriptor.fromBytes(markerIcon),
  //           markerId: const MarkerId('Place'),
  //           position: latLng,
  //           infoWindow: InfoWindow(
  //             snippet: street.subAdministrativeArea,
  //             title: 'my Place',
  //           ));
  //     }

  //     notifyListeners();
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  // }

  setCameraPosition(CameraPosition cameraPosition) {
    _cameraPosition = cameraPosition;
    notifyListeners();
  }

  getTime() async {
    var time = TimeOfDay.now();

    if (time.hour >= 5 && time.hour <= 11) {
      _greating = 'Good Morning';
    } else if (time.hour >= 12 && time.hour <= 14) {
      _greating = 'Good Afternoon';
    } else {
      _greating = 'Good Evening';
    }
    notifyListeners();
  }

  markerDragState(bool state) {
    _dragState = state;
    print('State is:' + _dragState.toString());
    notifyListeners();
  }
}
