import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ChatScreen/ChatScreen.dart';
import '../HomeScreen/HomeScreen.dart';
import '../ProfileScreen/ProfileScreen.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int currentIndex = 0;

  List listOfColors = [const HomeScreen(), ChatScreen(), const ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOfColors[currentIndex]!,
      bottomNavigationBar: BottomNavyBar(
        containerHeight: 55,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemCornerRadius: 12.0,
        iconSize: 26,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const Icon(Icons.home),
            title: Text(
              'Home',
              style: GoogleFonts.kumbhSans(
                  color: const Color.fromRGBO(31, 69, 86, 1)),
            ),
            inactiveColor: Colors.grey,
            activeColor: const Color.fromRGBO(31, 69, 86, 0.2),
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const Icon(CupertinoIcons.chat_bubble_2),
            inactiveColor: Colors.grey,
            title: Text(
              'Chat',
              style: GoogleFonts.kumbhSans(
                  color: const Color.fromRGBO(31, 69, 86, 1)),
            ),
            activeColor: const Color.fromRGBO(31, 69, 86, 0.2),
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const Icon(Icons.person),
            title: Text(
              'Profile',
              style: GoogleFonts.kumbhSans(
                  color: const Color.fromRGBO(31, 69, 86, 1)),
            ),
            inactiveColor: Colors.grey,
            activeColor: const Color.fromRGBO(31, 69, 86, 0.2),
          ),
        ],
      ),
    );
  }
}
