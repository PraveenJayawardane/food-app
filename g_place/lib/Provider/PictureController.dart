import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PictureController with ChangeNotifier {
  late Uint8List _markerIcon1;
  Uint8List get markerIcon1 => _markerIcon1;
  late Uint8List _markerIcon2;
  Uint8List get markerIcon2 => _markerIcon2;

  initilization(String icon1, String icon2) async {
    await getIcon(icon1, icon2);
  }

  Future getIcon(String icon1, String icon2) async {
    _markerIcon1 = await getBytesFromAsset(icon1, 50);
    _markerIcon2 = await getBytesFromAsset(icon2, 70);
    notifyListeners();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
