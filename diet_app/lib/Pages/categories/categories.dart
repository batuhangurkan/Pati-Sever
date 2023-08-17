import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../services/auth.dart';

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20),
            child: Row(
              children: [
                Text("Beyaz Kedi Cinsleri",
                    style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10,),


              ],
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.paw, color: Colors.deepOrangeAccent,),
            title: Text("Kıbrıs Kedisi"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.paw, color: Colors.deepOrangeAccent,),
            title: Text("Kıbrıs Kedisi"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20),
            child: Row(
              children: [
                Text("Büyük Kedi Cinsleri",
                    style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10,),
              ],
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.paw, color: Colors.deepOrangeAccent,),
            title: Text("Köpek"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.paw, color: Colors.deepOrangeAccent,),
            title: Text("Kıbrıs Kedisi"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20),
            child: Row(
              children: [
                Text("Büyümeyen Kedi Cinsleri",
                    style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10,),
              ],
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.paw, color: Colors.deepOrangeAccent,),
            title: Text("Köpek"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.paw, color: Colors.deepOrangeAccent,),
            title: Text("Kıbrıs Kedisi"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20),
            child: Row(
              children: [
                Text("Çocuk Dostu Kediler",
                    style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10,),
              ],
            ),
          ),
          ListTile(
            leading: CircleAvatar(
    child: Image.asset("assets/images/cat_3382653.png"),
    ),
            title: Text("Köpek"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.paw, color: Colors.deepOrangeAccent,),
            title: Text("Kıbrıs Kedisi"),
          ),
        ],
      ),
    );
  }
}
