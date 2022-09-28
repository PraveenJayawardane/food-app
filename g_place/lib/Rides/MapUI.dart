import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:g_place/FirstUI.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:load/load.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Provider/Google_service.dart';

import 'SearchPlace.dart';

class PractiseUI extends StatefulWidget {
  const PractiseUI({Key? key}) : super(key: key);

  @override
  State<PractiseUI> createState() => _PractiseUIState();
}

class _PractiseUIState extends State<PractiseUI> {
  @override
  void initState() {
    super.initState();
    showAndDelayDismiss();
  }

  void showAndDelayDismiss(
      [Duration duration = const Duration(seconds: 2)]) async {
    var future = await showCustomLoadingWidget(
        Center(
          child: Container(
              padding: const EdgeInsets.all(30),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 142, 137, 137),
                    borderRadius: BorderRadius.circular(10)),
                height: 70,
                width: 70,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 42, 41, 41),
                )),
              )),
        ),
        tapDismiss: false);
    ;
    Future.delayed(duration, () {
      future.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<GoogleService>(builder: (context, value, child) {
      return SafeArea(
          child: value.locationSreviceActive
              ? Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: GoogleMap(
                        onCameraMove: (CameraPosition cameraPositiona) {
                          value.markerDragState(true);
                          value.setCameraPosition(cameraPositiona);
                        },

                        onCameraIdle: () async {
                          await value.markerDragState(false);
                          print('false');

                          await value.street
                              .getPlaceMark(value.cameraPosition.target);
                          if (value.street.connectionState) {
                            checkConnectionFlushbar();
                          }
                        },

                        // markers: value.marker.markerId.value == 'value'
                        //     ? <Marker>{}
                        //    : <Marker>{value.marker},

                        mapType: MapType.normal,
                        // markers: <Marker>{
                        //   const Marker(
                        //       markerId: MarkerId('value'),
                        //       position:
                        //           LatLng(6.819921848183848, 79.96298309415579))
                        // },

                        initialCameraPosition: CameraPosition(
                            target: value.locationPosition, zoom: 16.5),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,

                        onMapCreated: (GoogleMapController controller) {
                          if (!value.complete.isCompleted) {
                            value.complete.complete(controller);
                          }
                        },
                      ),
                    ),
                    Center(
                      child: value.dragState
                          ? Container(
                              height: 200,
                              width: 30,
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset('assets/women.png')),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.transparent),
                            )
                          : Container(
                              height: 180,
                              width: 30,
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset('assets/women.png')),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.transparent),
                            ),
                    ),
                    Center(
                      child: value.dragState
                          ? Container(
                              height: 7,
                              width: 7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black),
                            )
                          : const SizedBox(),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: const SearchPlace()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(18, 30, 8, 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Row(
                                  children: [
                                    const Text('PICKUP',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 15)),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: value.dragState
                                          ? Text(
                                              'Fetching location...',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontStyle: FontStyle.normal),
                                            )
                                          : Text(
                                              'Location fetched',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 15,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                      //     child: Text(
                                      //   value.liveLocation,
                                      //   style: GoogleFonts.roboto(
                                      //       fontSize: 15,
                                      //       fontStyle: FontStyle.normal),
                                      // )
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 2),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.12,
                                      ),
                                      Container(
                                        color: Colors.grey,
                                        height: 1,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 2),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text('DROP',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 15)),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      Expanded(
                                          child: Text(
                                        'Where are you going?',
                                        style: GoogleFonts.roboto(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontStyle: FontStyle.normal),
                                      )),
                                    ],
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     IconButton(
                                //       splashColor: Colors.grey,
                                //       icon: Icon(Icons.room),
                                //       onPressed: () {},
                                //     ),
                                //     Expanded(
                                //       child: Text(value.onTapPlace),
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 200,
                        right: 5,
                        child: FloatingActionButton.small(
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.my_location,
                              color: Colors.black),
                          onPressed: (() {
                            value.getCurentMapCamera(value.locationPosition);
                            print(value.locationPosition);
                          }),
                        )),
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
                            onPressed: () => Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: const FirstUI())),
                          ),
                        ))
                  ],
                )
              : const Center(child: Text('')));
    }));
  }

  void checkConnectionFlushbar() async {
    return Flushbar(
      backgroundColor: const Color.fromARGB(255, 238, 18, 3),
      flushbarPosition: FlushbarPosition.TOP,
      messageText: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cancel,
            size: 28.0,
            color: Colors.white,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            'A data connection is not currently allowed.',
            style: GoogleFonts.roboto(color: Colors.white),
          ),
        ],
      )),
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
