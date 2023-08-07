import 'dart:io';
import 'package:diet_app/Pages/homepage.dart';
import 'package:diet_app/Pages/login.dart';
import 'package:diet_app/Pages/mama.dart';
import 'package:diet_app/Pages/newpostpage.dart';
import 'package:diet_app/Pages/profilepage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    MamaPage(),
    NewPostPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        margin: EdgeInsets.all(10),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.green,
        backgroundColor: Color.fromARGB(213, 8, 197, 118),
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.cat),
            title: Text(""),
            unselectedColor: Colors.white,
            selectedColor: Colors.white,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.moneyCheckDollar),
            title: Text(""),
            unselectedColor: Colors.white,
            selectedColor: Colors.white,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.dog),
            title: Text(""),
            unselectedColor: Colors.white,
            selectedColor: Colors.white,
          ),

          /// Profile
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
