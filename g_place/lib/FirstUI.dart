import 'package:flutter/material.dart';
import 'package:g_place/Activities.dart';
import 'package:g_place/CheckConnection/CheckConnection.dart';

import 'package:g_place/Person.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:page_transition/page_transition.dart';

import 'Food/FoodUi.dart';
import 'Provider/Google_service.dart';
import 'Notifications.dart';
import 'Rides/MapUI.dart';

class FirstUI extends StatefulWidget {
  const FirstUI({Key? key}) : super(key: key);

  @override
  State<FirstUI> createState() => _FirstUIState();
}

class _FirstUIState extends State<FirstUI> {
  @override
  void initState() {
    super.initState();

    Provider.of<GoogleService>(context, listen: false).initalization();
    Provider.of<CheckConnection>(context, listen: false).initConnectivity();
    Provider.of<CheckConnection>(context, listen: false).listenersForConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 248, 214, 112),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () async {},
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                  size: 30,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const Activities(),
                          type: PageTransitionType.bottomToTop));
                },
                icon: const Icon(
                  Icons.menu_outlined,
                  size: 30,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const Notifications(),
                          type: PageTransitionType.bottomToTop));
                },
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 30,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const Person(),
                          type: PageTransitionType.bottomToTop));
                },
                icon: const Icon(
                  Icons.person_outline,
                  size: 30,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Color.fromARGB(255, 253, 212, 88),
              Color.fromARGB(255, 236, 205, 113),
              Colors.white
            ], begin: Alignment.topCenter, end: Alignment.bottomRight)),
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 20),
              child: Text(
                  '${Provider.of<GoogleService>(context).greating}'
                  ',\n'
                  'Praveen Jayawardane',
                  style: GoogleFonts.aBeeZee(fontSize: 17)),
            ),
          ),
          SlidingUpPanel(
            color: Colors.white,
            defaultPanelState: PanelState.OPEN,
            maxHeight: MediaQuery.of(context).size.height / 1.4,
            minHeight: MediaQuery.of(context).size.height * 0.3,
            header: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10)),
                        height: 5,
                        width: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            panelBuilder: (ScrollController controller) => Container(
              margin: const EdgeInsets.only(top: 20),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                controller: controller,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        child: const PractiseUI()));
                              },
                              child: ClipRRect(
                                child: Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/frr.png')),
                                  height: 80,
                                  width: 100,
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Text("Rides",
                              style: GoogleFonts.aBeeZee(fontSize: 15))
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const FoodUi(),
                                        type: PageTransitionType.rightToLeft));
                              },
                              child: ClipRRect(
                                child: Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/fd.png')),
                                  height: 80,
                                  width: 100,
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Text("Food", style: GoogleFonts.aBeeZee(fontSize: 15))
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              child: ClipRRect(
                                child: Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/sp.png')),
                                  height: 80,
                                  width: 100,
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Text("Market",
                              style: GoogleFonts.aBeeZee(fontSize: 15))
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              child: ClipRRect(
                                child: Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/flash.png')),
                                  height: 60,
                                  width: 60,
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Text("Flash",
                              style: GoogleFonts.aBeeZee(fontSize: 15))
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              child: ClipRRect(
                                child: Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/truck.png')),
                                  height: 60,
                                  width: 60,
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Text("Truck",
                              style: GoogleFonts.aBeeZee(fontSize: 15))
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              child: ClipRRect(
                                child: Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/qr.png')),
                                  height: 60,
                                  width: 60,
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Text("Scan N' Go",
                              style: GoogleFonts.aBeeZee(fontSize: 15))
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      "Where are you going?",
                      style: GoogleFonts.aBeeZee(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          cursorWidth: 0,
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: const PractiseUI()));
                          },
                          keyboardType: TextInputType.none,
                          decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              suffixIcon:
                                  const Icon(Icons.search, color: Colors.grey),
                              suffixIconColor: Colors.black,
                              hintText: 'Serch for destination',
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      'assets/sl.jpg',
                                      fit: BoxFit.cover,
                                    ))),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  'If golden beaches, rising waves, misty mountains, mighty elephants, stealthy leopards, giant whales, a majestic past, lovely tea and warm smiles could sum up a country, that would be Sri Lanka.With many sites and scenes bottled up in to a small island, a traveller could be riding the waves in the dawn and admiring the green carpeted mountains by dusk. Travel destinations in Sri Lanka provide an array of holiday experience from sun kissed beach holidays to a marathon of wildlife watching, adrenaline pumping adventure sports and pilgrimage to some of the oldest cities in the world.'),
                            ),
                          ],
                        ),
                        width: 500,
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      'assets/slFd.jpg',
                                      fit: BoxFit.cover,
                                    ))),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  'The cultivation of many types of rice, spices, vegetables and fruit, coupled with past foreign influences, ensures that Sri Lanka enjoys a varied and select cuisine. As a staple, rice is consumed with an assortment of colourful curries (eggplant, potato, green banana, chicken, fish) that range in potency from delicately-spiced to near-dynamite.'),
                            ),
                          ],
                        ),
                        width: 500,
                        color: Colors.black12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.32,
                  left: MediaQuery.of(context).size.width * 0.01,
                  right: MediaQuery.of(context).size.width * 0.01,
                  child: Image.asset(
                    'assets/travel.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            // body: Center(
            //   child: SizedBox(
            //       height: MediaQuery.of(context).size.height * 0.4,
            //       child: Image.asset(
            //         'assets/travel.png',
            //         fit: BoxFit.contain,
            //       )),
            // ),
          ),
        ],
      )),
    );
  }
}
