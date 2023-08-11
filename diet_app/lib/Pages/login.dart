import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:diet_app/Pages/register.dart';
import 'package:diet_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:m_toast/m_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  ShowMToast toast = ShowMToast();
  String greetings() {
    final hour = TimeOfDay.now().hour;

    if (hour <= 12) {
      return 'Günaydın ☀️ Pati sever!';
    } else if (hour <= 17) {
      return 'İyi Akşamlar 🌤️ Pati sever!';
    }
    return 'İyi Geceler 🌙 Pati sever!';
  }

  Future updateDisplayName(String newDisplayName) async {
    var user = await FirebaseAuth.instance.currentUser;
    user!.updateDisplayName(newDisplayName);
  }

  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  AuthService _authService = AuthService();
  bool _visibility = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/birman-cat.png",
                    height: 150,
                    width: 150,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Center(
                    child: Text(
                      greetings() + ",",
                      style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                      "Kullanıcı girişini yaparak uygulamaya devam edebilirsin.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                          fontSize: 15,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.normal)),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                      child: Text(
                        "E-posta",
                        style: TextStyle(
                          color: Colors.grey[200],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _emailcontroller,
                    decoration: InputDecoration(

                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey[200],
                      ),
                      hintStyle: GoogleFonts.ubuntu(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                      child: Text(
                        "Şifre",
                        style: TextStyle(
                          color: Colors.grey[200],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _passwordcontroller,
                    obscureText: _visibility,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey[200],
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _visibility ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey[400],
                        ),
                        onPressed: () {
                          setState(() {
                            _visibility = !_visibility;
                          });
                        },
                      ),
                      hintStyle: GoogleFonts.ubuntu(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
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
                              color: Colors.grey[200],
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline))),
                  onTap: () {
                    //şifremi sıfırla
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'resetpasswordpage', (Route<dynamic> route) => true);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('email', _emailcontroller.text);
                        await prefs.setString('password', _passwordcontroller.text);
                        setState(() {
                          Future.delayed(Duration(seconds: 2), () {
                            _authService
                                .signIn(_emailcontroller.text,
                                _passwordcontroller.text)
                                .then((value) {

                              IconSnackBar.show(
                                  context: context,
                                  label: "Giriş yapılan hesap:" +
                                      _emailcontroller.text,
                                  snackBarType: SnackBarType.save,
                                  duration: Duration(seconds: 3));
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/bottomnavigationbar',
                                      (Route<dynamic> route) => false);
                            });

                          });
                         if (_emailcontroller.text == '' &&
                              _passwordcontroller.text == '') {
                            IconSnackBar.show(

                                context: context,
                                label: "E-Posta veya Şifre boş bırakılamaz!",
                                snackBarType: SnackBarType.fail,
                                duration: Duration(seconds: 3));
                          } else if (_emailcontroller.text == '') {
                            IconSnackBar.show(
                                context: context,
                                label: "E-Posta boş bırakılamaz!",
                                snackBarType: SnackBarType.fail,
                                duration: Duration(seconds: 3));
                          } else if (_passwordcontroller.text == '') {
                            IconSnackBar.show(
                                context: context,
                                label: "Şifre boş bırakılamaz!",
                                snackBarType: SnackBarType.fail,
                                duration: Duration(seconds: 3));
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            15.0), //content padding inside button
                        primary: Colors.brown[50],
                        shape: StadiumBorder(),
                      ),
                      child: Text('Giriş Yap', style: GoogleFonts.ubuntu(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold
                      ,),)),
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
                                color: Colors.grey[200], fontSize: 15),
                            children: [
                          TextSpan(
                              text: "Kayıt Olun",
                              style: TextStyle(
                                  color: Colors.blueAccent[200],
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
