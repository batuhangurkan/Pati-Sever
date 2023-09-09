import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
              child: FaIcon(
            FontAwesomeIcons.envelope,
            color: Colors.white,
            size: 100,
          )),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              "Email Doğrulaması",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              "E-mailinizi doğrulayabilmeniz için size bir link gönderdik. \nLütfen e-mailinizi kontrol ediniz ve mailinizi doğrulayınız. E-mailinizi zaten doğruladıysanız aşağıdaki 'devam et' butona tıklayınız.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.getString('email' ?? '');
                  user!.sendEmailVerification();
                },
                child: Text("E-maili Tekrar Gönder"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () async {
                 await user?.reload();
                  Navigator.pushNamed(context, 'login').then((value) => user?.reload());
                },
                child: Text("Devam et"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
