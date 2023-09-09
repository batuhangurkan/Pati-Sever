import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_app/services/auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diet_app/services/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_manager/theme_manager.dart';
import 'dart:io';
import 'package:quickalert/quickalert.dart';

import '../login.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 50,
      maxWidth: 50,
      imageQuality: 75,
    );

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("Pictures")
        .child(user!.uid + ".jpg");

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) async {
      print(value);
      setState(() {
        imageUrl = value;
      });
    });

    await FirebaseFirestore.instance
        .collection("Person")
        .doc(user!.uid)
        .update({
      "imageUrl": imageUrl,
    });
  }
  String imageUrl = "";
  String deleteAccount = "delete";
  TextEditingController _deleteAccountController = TextEditingController();
  AuthService _authService = AuthService();
  User? user = FirebaseAuth.instance.currentUser;
  bool isDarkMode = false;
  bool isNotification = false;
  bool isvisible = false;
  bool isvisible2 = false;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();


  Future _updatePassword(String password) async {
    try {
      await FirebaseAuth.instance.currentUser!
          .updatePassword(_passwordController.text.trim())
          .then((value) => print("Şifre güncellendi."));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _loadSwitchValue();
    super.initState();
  }

  void _getProfilePicture() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Person")
        .doc(user!.uid)
        .get();
    setState(() {
      imageUrl = doc['imageUrl'];
    });
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
    var signupDate = user?.metadata.creationTime;
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
                          child: GestureDetector(
                            onTap: () async {
                              pickUploadImage();
                            },
                            child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                // ignore: unnecessary_null_comparison
                                child: ClipOval(
                                    child: Image.asset(
                                        "assets/images/cat_3382653.png"))),
                          )),
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
                readOnly: true,
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
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: _passwordController,
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
                controller: _passwordConfirmController,
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
                  onPressed: () {
                    if(_passwordController.text == _passwordConfirmController.text) {
                      _updatePassword(_passwordController.text.trim());
                      setState(() {
                        _passwordController.clear();
                        _passwordConfirmController.clear();
                        Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
                      });
                      var snackBar = SnackBar(
                        content: Text("Şfreniz başarıyla güncellendi."),
                        duration: Duration(seconds: 2, milliseconds: 500),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Future.delayed(Duration(seconds: 2), () {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.all(15.0), //content padding inside button
                    primary: Colors.deepOrangeAccent,
                    shape: StadiumBorder(),
                  ),
                  child: Text('Bilgilerini Güncelle')),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.brown[50],
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                height: MediaQuery.of(context).size.height / 9,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Hesap Oluşturma Tarihi:",
                      style: GoogleFonts.ubuntu(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(DateFormat.yMMMMEEEEd().format(signupDate!),
                        style: GoogleFonts.ubuntu(color: Colors.black)),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: ElevatedButton(
                          onPressed: () {
                            QuickAlert.show(
                              title:
                                  "Hesabınızı silmek istediğinize emin misiniz ?",
                              text:
                                  "Hesabınızı silmek için aşağıdaki kutucuğa 'delete' yazıp onaylayın.",
                              context: context,
                              showCancelBtn: false,
                              type: QuickAlertType.warning,
                              barrierDismissible: true,
                              confirmBtnColor: Colors.redAccent,
                              confirmBtnText: "Hesabımı Sil",
                              cancelBtnText: "Hayır",
                              widget: TextFormField(
                                controller: _emailcontroller,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.mail_outline,
                                    color: Colors.grey[400],
                                  ),
                                  hintText: "'delete' yazın",
                                  hintStyle: GoogleFonts.ubuntu(
                                      color: Colors.brown[400]),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                              onConfirmBtnTap: () async {
                                if (_emailcontroller.text == deleteAccount) {
                                  AuthService _authService = AuthService();
                                  user?.delete().then((Function) => null);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                      (route) => false);
                                  var snackBar = SnackBar(
                                    content: Text("Pati Sever Hesabınız Silindi."),
                                    duration: Duration(seconds: 2, milliseconds: 500),
                                    backgroundColor: Colors.green,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Future.delayed(Duration(seconds: 2), () {});
                                } else {}
                              },
                              onCancelBtnTap: () {
                                Navigator.pop(context);
                              },
                            );
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
