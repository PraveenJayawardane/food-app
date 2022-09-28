import 'dart:async';
import 'package:flutter/material.dart';
import 'package:g_place/Provider/Google_service.dart';
import 'package:g_place/Provider/PictureController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Provider/MapUtils.dart';
import 'MapUI.dart';

class NavigaterMapUi extends StatefulWidget {
  final LatLng latLng;
  const NavigaterMapUi(this.latLng, {Key? key}) : super(key: key);

  @override
  State<NavigaterMapUi> createState() => _NavigaterMapUiState(latLng);
}

class _NavigaterMapUiState extends State<NavigaterMapUi> {
  late GoogleMapController mapController;
  LatLng latLng;

  _NavigaterMapUiState(this.latLng);

  @override
  Widget build(BuildContext context) {
    List<String> _catogory = ['Tuk', 'Flex', 'Mini', 'Car'];
    List<String> _capacity = ['2', '3', '3', '4'];
    List<String> _payment = [
      'LKR 1208.00',
      'LKR 1848.00',
      'LKR 12508.00',
      'LKR 15208.00'
    ];
    Set<Marker> _markers = {
      Marker(
          markerId: const MarkerId('start'),
          position: Provider.of<GoogleService>(context, listen: false)
              .locationPosition,
          icon: BitmapDescriptor.fromBytes(
              Provider.of<PictureController>(context, listen: false)
                  .markerIcon1)),
      Marker(
          markerId: const MarkerId('end'),
          position: latLng,
          icon: BitmapDescriptor.fromBytes(
              Provider.of<PictureController>(context, listen: false)
                  .markerIcon2))
    };
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                      target: Provider.of<GoogleService>(context, listen: false)
                          .locationPosition,
                      zoom: 15,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      Future.delayed(
                          const Duration(milliseconds: 200),
                          () => controller.animateCamera(
                              CameraUpdate.newLatLngBounds(
                                  MapUtils.boundsFromLatLngList(_markers
                                      .map((loc) => loc.position)
                                      .toList()),
                                  1)));
                    }),
                Positioned(
                    top: 20,
                    left: 5,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      width: 50,
                      child: BackButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const PractiseUI()));
                          Provider.of<GoogleService>(context, listen: false)
                              .initalization();
                        },
                      ),
                    ))
              ],
            ),
          ),
          Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Stack(
                children: [
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 100,
                                width: 90,
                                color: Colors.black12,
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 50,
                                        width: 80,
                                        child: Image.asset(
                                          'assets/$index.png',
                                          fit: BoxFit.fitWidth,
                                        )),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(_catogory[index]),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                        ),
                                        const Icon(
                                          Icons.person_outline,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                        ),
                                        Text(_capacity[index]),
                                      ],
                                    ),
                                    const Divider(
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    Text(_payment[index])
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 5,
                    left: MediaQuery.of(context).size.width * 0.02,
                    child: GestureDetector(
                      onTap: () {
                        print('tap');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: Colors.amber,
                          child: const Center(child: Text('Book Now')),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: MediaQuery.of(context).size.width * 0.02,
                    child: GestureDetector(
                      onTap: () {
                        print('tap');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.black,
                          child: const Center(
                              child: Text(
                            'Later',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}
