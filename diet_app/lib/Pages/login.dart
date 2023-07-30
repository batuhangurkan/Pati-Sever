import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:diet_app/Pages/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                Center(
                  child: Container(
                    child: Image.asset(
                      'assets/images/loading.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                Text('Tekrardan Hoşgeldiniz,',
                    style: GoogleFonts.ubuntu(
                        fontSize: 20,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'E-Posta',
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
                      hintText: 'Şifre',
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
                InkWell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(250, 0, 0, 25),
                      child: Text("Şifremi Unuttum",
                          style: GoogleFonts.ubuntu(
                              fontSize: 15,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline))),
                  onTap: () {
                    //şifremi sıfırla
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: ElevatedButton(
                      onPressed: () {
                        var snackBar = SnackBar(
                          content: Text("Giriş Yapıldı"),
                          duration: Duration(seconds: 2, milliseconds: 500),
                          backgroundColor: Colors.green,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Future.delayed(Duration(seconds: 2), () {});
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/bottomnavigationbar',
                            (Route<dynamic> route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 100.0, vertical: 15.0),
                        primary: Color.fromARGB(255, 2, 187, 79),
                        shape: StadiumBorder(),
                      ),
                      child: Text('Giriş Yap')),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    child: RichText(
                        text: TextSpan(
                            text: "Hesabınız yok mu? ",
                            style: GoogleFonts.poppins(
                                color: Colors.grey[500], fontSize: 15),
                            children: [
                          TextSpan(
                              text: "Kayıt Olun",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold))
                        ])),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
