import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_manager/theme_manager.dart';

import '../services/auth.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isDarkMode = false;
  bool isNotification = false;

  @override
  void initState() {
    _loadSwitchValue();
    super.initState();
  }

  void _loadSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  final List<Map> myGridList = List.generate(2, (index) => {});
  @override
  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();
    final User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Kategoriler',
            style: GoogleFonts.ubuntu(
              fontSize: 20,
              color: Colors.black,
            )),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
              child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.shieldCat,
                  color: Colors.deepOrangeAccent,
                ),
                onPressed: () {},
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
              child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.gift,
                  color: Colors.green,
                ),
                onPressed: () {},
              ))
        ],
        leading: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 8,
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.deepOrangeAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: Row(
                children: [
                  Text("Kısa Tüylü Kedi Cinsleri",
                      style: GoogleFonts.ubuntu(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  child: Image.asset("assets/images/bengal-kedisi.jpg"),
                  backgroundColor: Colors.white,
                ),
              ),
              title: Text("Bengal Kedisi"),
            ),
            ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    child: Image.asset("assets/images/british.jpg"),
                  )),
              title: Text("British Shorthair"),
            ),
            ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    child: Image.asset("assets/images/siyam.jpg"),
                  )),
              title: Text("Siyam Kedisi"),
            ),
            ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    child: Image.asset("assets/images/devon-rex.jpg"),
                  )),
              title: Text("Devon Rex Cat"),
            ),
            ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    child: Image.asset("assets/images/mavi-rus.jpg"),
                  )),
              title: Text("Mavi Rus Kedisi"),
            ),
            ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    child: Image.asset("assets/images/scottish-fold1.jpg"),
                  )),
              title: Text("Scottish Fold"),
            ),
            ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    child: Image.asset("assets/images/exotic.jpg"),
                  )),
              title: Text("Exotic Shorthair"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: Row(
                children: [
                  Text("Uzun Tüylü Kedi Cinsleri",
                      style: GoogleFonts.ubuntu(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  child: Image.asset("assets/images/iran-kedisi.jpg"),
                  backgroundColor: Colors.white,
                ),
              ),
              title: Text("İran Kedisi"),
            ),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  child: Image.asset("assets/images/van-kedisi.jpg"),
                  backgroundColor: Colors.white,
                ),
              ),
              title: Text("Van Kedisi"),
            ),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  child: Image.asset("assets/images/maine-coon.jpg"),
                  backgroundColor: Colors.white,
                ),
              ),
              title: Text("Maine Coon"),
            ),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  child: Image.asset("assets/images/ragdoll.jpg"),
                  backgroundColor: Colors.white,
                ),
              ),
              title: Text("Ragdoll Kedisi"),
            ),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  child: Image.asset("assets/images/muchkin.jpg"),
                ),
              ),
              title: Text("Munchkin"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: Row(
                children: [
                  Text("Tüysüz Kedi Cinsleri",
                      style: GoogleFonts.ubuntu(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  child: Image.asset("assets/images/sfenks-kedisi.jpg"),
                  backgroundColor: Colors.white,
                ),
              ),
              title: Text("Sfenks Kedisi"),
            ),
          ],
        ),
      ),
    );
  }
}
