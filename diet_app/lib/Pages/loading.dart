import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  bool activeconnection = false;
  String _feedback = "loadingText".tr().toString();
  String _feedback2 = "Tekrar Dene";

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Image.asset(
              "assets/images/loading.png",
              width: 150,
              height: 150,
            ),
            Column(
              children: [
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
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Image.asset(
                            'assets/images/loading2.png',
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
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
