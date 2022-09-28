import 'package:flutter/material.dart';
import 'package:g_place/CheckConnection/CheckConnection.dart';
import 'package:g_place/FirstUI.dart';
import 'package:g_place/Provider/Google_service.dart';
import 'package:g_place/Provider/PictureController.dart';
import 'package:g_place/Provider/Street.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';

void main() {
 

  runApp(LoadingProvider(
    themeData: LoadingThemeData(),
    child: MultiProvider(
      child: const MaterialApp(
        home: MapScreen(),
        debugShowCheckedModeBanner: false,
      ),
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleService()),
        ChangeNotifierProvider(create: (_) => Street()),
        ChangeNotifierProvider(create: (_) => CheckConnection()),
        ChangeNotifierProvider(create: (_) => PictureController())
      ],
    ),
  ));
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(body: FirstUI()),
    );
  }
}
