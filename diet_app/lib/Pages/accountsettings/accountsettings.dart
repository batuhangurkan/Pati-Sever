import 'dart:math';

import 'package:diet_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diet_app/services/auth.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

@override
List<DropdownMenuItem<dynamic>>? _items = [
  DropdownMenuItem(
    child: Text("Türkçe"),
    value: "Türkçe",
  ),
  DropdownMenuItem(
    child: Text("English"),
    value: "English",
  ),
];

items({required Icon icon, required Text title}) {}

class _AccountSettingsState extends State<AccountSettings> {
  AuthService _authService = AuthService();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 197, 119),
        centerTitle: true,
        title: Text('Hesap Ayarları',
            style: GoogleFonts.ubuntu(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
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
                  color: Color.fromARGB(255, 8, 197, 119),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                          radius: 25,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 60, top: 75),
                          )),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Hesap Kartın",
                            style: GoogleFonts.ubuntu(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Text(user?.email ?? "",
                                style: GoogleFonts.ubuntu(
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 26, 25, 25),
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
            height: 10,
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
                hintStyle: GoogleFonts.ubuntu(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: Colors.grey[400],
                ),
                hintText: user?.email ?? "E-Posta Adresinizi Girin",
                hintStyle: GoogleFonts.ubuntu(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: Colors.grey[400],
                ),
                hintText: "Şifrenizi Girin",
                hintStyle: GoogleFonts.ubuntu(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: Colors.grey[400],
                ),
                hintText: "Şifrenizi Tekrar Girin",
                hintStyle: GoogleFonts.ubuntu(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButton(
              items: _items,
              onChanged: (value) {
                print(value);
              })
        ],
      ),
    );
  }
}
