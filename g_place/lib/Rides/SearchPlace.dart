import 'package:flutter/material.dart';

import 'package:g_place/Provider/Google_service.dart';
import 'package:g_place/Provider/LatLang.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Provider/PictureController.dart';
import 'NavigaterMapUi.dart';

class SearchPlace extends StatefulWidget {
  const SearchPlace({Key? key}) : super(key: key);

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  final List<LatLang> _list = [
    LatLang('galle', const LatLng(6.053519, 80.220978)),
    LatLang('jaffna', const LatLng(9.66845, 80.00742)),
    LatLang('ampara', const LatLng(7.29754, 81.68202)),
    LatLang('batticoloa', const LatLng(7.71666670, 81.70000000)),
  ];
  late String nameInPlace = 'xxxx';

  Future<List<LatLang>> data() async {
    List<LatLang> findPlace = [];
    for (LatLang name in _list) {
      if (name.nameOfPlace.substring(0, 1) == nameInPlace.substring(0, 1)) {
        findPlace.add(name);
      }
    }
    return findPlace;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<PictureController>(context, listen: false)
        .initilization('assets/myLoc.png', 'assets/myDes.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 221, 216, 216),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: [
                      const Text('PICKUP',
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 15)),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Text(
                        Provider.of<GoogleService>(context, listen: false)
                            .liveLocation,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            fontSize: 15, fontStyle: FontStyle.normal),
                      )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      children: [
                        Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 2),
                    child: Row(
                      children: [
                        Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20))),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.11,
                        ),
                        Container(
                          color: Colors.black,
                          height: 1,
                          width: MediaQuery.of(context).size.width / 1.4,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 2),
                    child: Row(
                      children: [
                        Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20))),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 8),
                    child: Row(
                      children: [
                        const Text('DROP',
                            style:
                                TextStyle(color: Colors.orange, fontSize: 15)),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: TextFormField(
                              onChanged: (String name) {
                                setState(() {
                                  nameInPlace = name;
                                });
                              },
                              decoration: const InputDecoration(
                                  hintStyle: TextStyle(fontSize: 15),
                                  border: InputBorder.none,
                                  hintText: 'Where are you going')),
                        ),
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
          FutureBuilder<List<LatLang>>(
            future: data(),
            builder: (context, AsyncSnapshot<List<LatLang>> snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                List<LatLang> data = snapshot.data!;
                return data.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: NavigaterMapUi(
                                            data[index].latLangOfPlace),
                                        type: PageTransitionType.topToBottom));
                              },
                              leading: const CircleAvatar(
                                  backgroundColor: Colors.black12,
                                  child: Icon(
                                    Icons.place_outlined,
                                    color: Colors.black,
                                  )),
                              title: Text(data[index].nameOfPlace));
                        },
                      )
                    : const Text('No data found');
              } else {
                return const SizedBox();
              }
            },
          )
        ]),
      )),
    );
  }
}
