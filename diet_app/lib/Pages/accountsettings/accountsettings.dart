import 'dart:math';

import 'package:diet_app/services/auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diet_app/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_manager/theme_manager.dart';

import '../login.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  String deleteAccount = "delete";
  TextEditingController _deleteAccountController = TextEditingController();
  AuthService _authService = AuthService();
  User? user = FirebaseAuth.instance.currentUser;
  bool isDarkMode = false;
  bool isNotification = false;
  bool isvisible = false;
  bool isvisible2 = false;
  TextEditingController _emailcontroller = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hesap Ayarları',
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
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.deepOrangeAccent,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/cat_3382653.png'),
                            radius: 25,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 60, top: 75),
                            )),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Hesap Kartın",
                                style: GoogleFonts.ubuntu(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(user?.email ?? "",
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 15,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                    color: Colors.grey[400],
                  ),
                  hintText: user?.displayName ?? "Kullanıcı Adınızı Girin",
                  hintStyle: GoogleFonts.ubuntu(color: Colors.brown[400]),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail_lock_outlined,
                    color: Colors.grey[400],
                  ),
                  hintText: user?.email ?? "E-posta Adresiniz",
                  hintStyle: GoogleFonts.ubuntu(color: Colors.brown[400]),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                obscureText: isvisible,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline_sharp,
                    color: Colors.grey[400],
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isvisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      setState(() {
                        isvisible = !isvisible;
                      });
                    },
                  ),
                  hintText: user?.displayName ?? "Şifre",
                  hintStyle: GoogleFonts.ubuntu(color: Colors.brown[400]),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.grey[400],
                  ),
                  hintText: user?.displayName ?? "Şifrenizi Onaylayın",
                  hintStyle: GoogleFonts.ubuntu(color: Colors.brown[400]),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.all(15.0), //content padding inside button
                    primary: Colors.deepOrangeAccent,
                    shape: StadiumBorder(),
                  ),
                  child: Text('Bilgilerini Güncelle')),
            ),
            SizedBox(height: 20,),
            Container(
                decoration: BoxDecoration(
                  color: Colors.brown[50],
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              height: MediaQuery.of(context).size.height / 9,
              width: MediaQuery.of(context).size.width / 1.2,
                child: Column(

                  children: [
                    SizedBox(height: 5,),
                    Text("Hesap Oluşturma Tarihi:", style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.bold),),
                    Text(user!.metadata.creationTime.toString()),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  AuthService _authService =
                                  AuthService();
                                  return AlertDialog(
                                    title: Text("Hesabımı Sil"),
                                    content: Text(
                                        "Hesabınızı Silmek İstediğinize Emin Misiniz?"),
                                    actions: [
                                      TextField(
                                        controller:
                                        _deleteAccountController,
                                        decoration: InputDecoration(
                                            hintText:
                                            "Hesabınızı Silmek İçin 'delete' yazınız."
                                                .tr()
                                                .toString()),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context);
                                          },
                                          child: Text("Hayır")),
                                      TextButton(
                                          onPressed: () {
                                            if (deleteAccount ==
                                                _deleteAccountController
                                                    .text) {
                                              Navigator.pop(
                                                  context);
                                              user?.delete().then(
                                                      (Function) =>
                                                  null);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          LoginPage()),
                                                      (route) =>
                                                  false);
                                              IconSnackBar.show(
                                                  context:
                                                  context,
                                                  label:
                                                  "Hesabınız başarıyla silindi!",
                                                  snackBarType:
                                                  SnackBarType
                                                      .save);
                                            } else if (deleteAccount !=
                                                _deleteAccountController
                                                    .text) {
                                              ScaffoldMessenger
                                                  .of(context)
                                                  .showSnackBar(SnackBar(
                                                  duration: Duration(
                                                      seconds:
                                                      1),
                                                  backgroundColor:
                                                  Colors
                                                      .red,
                                                  content: Text(
                                                      "Hesabınızı silmek için delete yazın!"
                                                          .tr()
                                                          .toString())));
                                            } else if (_deleteAccountController
                                                .text ==
                                                '') {
                                              ScaffoldMessenger
                                                  .of(context)
                                                  .showSnackBar(SnackBar(
                                                  duration: Duration(
                                                      seconds:
                                                      1),
                                                  backgroundColor:
                                                  Colors
                                                      .red,
                                                  content: Text(
                                                      "Boş geçileemez."
                                                          .tr()
                                                          .toString())));
                                            }
                                            ;
                                          },
                                          child: Text("Evet")),
                                    ],
                                  );
                                });
                          },
                          style: ElevatedButton.styleFrom(
                           //content padding inside button
                            primary: Colors.redAccent,
                            shape: StadiumBorder(),
                          ),
                          child: Text('Hesabını Sil')),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
