import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {

  String _email = "";
  String _password = "";

  AuthService _authService = AuthService();
  User? user = FirebaseAuth.instance.currentUser;
  bool activeconnection = false;
  String _feedback = "loadingText".tr().toString();
  String _feedback2 = "Tekrar Dene";

  Future Load_Data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? '';
    _password = prefs.getString('password') ?? '';


    if (_email != '' && _password != '') {
      var duration = const Duration(seconds: 2);
      //var duration2 = const Duration(seconds: 5);
      sleep(duration);
      print("giriş yapılıyor");
      await login();
    }
  }

    Future<void> login() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', _email);
      await prefs.setString('password', _password);
      setState(() {
        Future.delayed(Duration(seconds: 2), () {
          _authService
              .signIn(_email,
              _password)
              .then((value) {
            IconSnackBar.show(
                context: context,
                label: "Giriş yapılan hesap:" +
                    _email,
                snackBarType: SnackBarType.save,
                duration: Duration(seconds: 3));
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/bottomnavigationbar',
                    (Route<dynamic> route) => false);
          });
        });
        if (_email == '' &&
            _password == '') {
          IconSnackBar.show(
              context: context,
              label: "E-Posta veya Şifre boş bırakılamaz!",
              snackBarType: SnackBarType.fail,
              duration: Duration(seconds: 3));
        } else if (_email == '') {
          IconSnackBar.show(
              context: context,
              label: "E-Posta boş bırakılamaz!",
              snackBarType: SnackBarType.fail,
              duration: Duration(seconds: 3));
        } else if (_password == '') {
          IconSnackBar.show(
              context: context,
              label: "Şifre boş bırakılamaz!",
              snackBarType: SnackBarType.fail,
              duration: Duration(seconds: 3));
        }
      });
    }


      Future checkuserconnection() async {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            setState(() {
              Future.delayed(Duration(seconds: 5), () {
                activeconnection = true;
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'login', (Route<dynamic> route) => false);
              });
              _feedback = "loginNetConnectionSuccesText".tr().toString();
              _feedback2 = '';
            });
          }
        } on SocketException catch (_) {
          setState(() {
            activeconnection = false;
            _feedback =
            "İnternet bağlantısı başarısız!\nLütfen bağlantı ayarlarını kontrol ediniz.";
          });
        }
      }

      late final AnimationController _controller;
      @override
      void initState() {
        checkuserconnection();
        Load_Data();
        super.initState();
        Future.delayed(Duration(seconds: 10), () {});

        _controller = AnimationController(vsync: this);
      }

      @override
      void dispose() {
        _controller.dispose();
        super.dispose();
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.deepOrangeAccent,
          body: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                Image.asset(
                  "assets/images/birman-cat.png",
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    CircularProgressIndicator(color: Colors.white,),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text("from " + "Pati Sever 🐱",
                                    style: GoogleFonts.ubuntu(
                                        fontSize: 20,
                                        color: Colors.grey[200],
                                        fontWeight: FontWeight.normal)),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                if (activeconnection == false) ...[
                  Container(
                    child: Column(
                      children: [
                        Text(
                          _feedback,
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            checkuserconnection();
                          },
                          child: Text(
                            _feedback2,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ],
            ),
          ),
        );
      }
    }




