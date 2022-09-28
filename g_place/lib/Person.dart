import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'Activities.dart';
import 'FirstUI.dart';
import 'Notifications.dart';

class Person extends StatefulWidget {
  const Person({Key? key}) : super(key: key);

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 248, 214, 112),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const FirstUI(),
                          type: PageTransitionType.topToBottom));
                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
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
                onPressed: () {},
                icon: const Icon(
                  Icons.person_outlined,
                  size: 30,
                  color: Colors.black,
                ))
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 50),
            child: Text('Person', style: GoogleFonts.roboto(fontSize: 18)),
          )
        ],
      )),
    );
  }
}
