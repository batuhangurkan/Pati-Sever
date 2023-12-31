import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_app/Pages/emailverificationpage.dart';
import 'package:diet_app/Pages/login.dart';
import 'package:diet_app/Pages/mama.dart';
import 'package:diet_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final currentUser = FirebaseAuth.instance;
  bool _visibility = false;
  bool _visibility2 = false;
  bool _checkvisibility = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordAgainController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  AuthService _authService = AuthService();



  Future sendVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    SharedPreferences prefs =
        await SharedPreferences.getInstance();
    await prefs.getString('email' ?? '');
    user!.sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text("Kayıt Sayfası,",
                      style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                        "Kayıt olmak için lütfen aşağıdaki alanları doldurunuz.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                            fontSize: 15,
                            color: Colors.grey[200],
                            fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                        child: Text(
                          "Adınız Soyadınız",
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
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
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
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
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
                      controller: _emailController,
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
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
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
                      obscureText: _visibility,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey[200],
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _visibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey[200],
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
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                        child: Text(
                          "Şifre Onayı",
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
                      obscureText: _visibility2,
                      controller: _passwordAgainController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _visibility2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey[200],
                          ),
                          onPressed: () {
                            setState(() {
                              _visibility2 = !_visibility2;
                            });
                          },
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ElevatedButton(
                        onPressed: () async {
                          await user?.reload();

                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            await prefs.setString(
                                'email', _emailController.text);
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty &&
                              _passwordAgainController.text.isNotEmpty &&
                              _usernameController.text.isNotEmpty && _checkvisibility == true ) {
                            setState(() {

                              _authService
                                  .createPerson(
                                      _emailController.text,
                                      _passwordController.text,
                                      _usernameController.text)
                                  .then((value) {
                                sendVerification();
                                Navigator.of(context).pushNamedAndRemoveUntil('emailverificationpage', (route) => false);
                              });
                              IconSnackBar.show(
                                  duration: Duration(seconds: 3),
                                  context: context,
                                  snackBarType: SnackBarType.save, label: 'Başarılı bir şekilde kayıt oldunuz!');

                            });
                          } else if (  _checkvisibility = false) {

                            IconSnackBar.show(
                                duration: Duration(seconds: 3),
                                context: context,
                                snackBarType: SnackBarType.fail,
                                label: 'Kullanım koşullarını kabul etmeden kayıt olamazsınız!');
                          }
                          else {
                            IconSnackBar.show(
                                duration: Duration(seconds: 3),
                                context: context,
                                snackBarType: SnackBarType.fail,
                                label: 'Kayıt olurken boş alan bırakılamaz!');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100.0, vertical: 15.0),
                          primary: Colors.brown[50],
                          shape: StadiumBorder(),
                        ),
                        child: Text(
                          'Kayıt Ol',
                          style: GoogleFonts.ubuntu(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: CheckboxListTile(
                          checkColor: Colors.deepOrangeAccent,
                          fillColor: MaterialStateProperty.all(Colors.white),
                          title: Text(
                            "Kullanım Koşulları ve Gizlilik Politikası",
                            style: GoogleFonts.ubuntu(
                                fontSize: 15,
                                color: Colors.grey[200],
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.underline),
                          ),
                          value: _checkvisibility,
                          onChanged: (newValue) {
                            setState(() {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Kullanım Koşulları ve Gizlilik Politikası"),
                                      content: Text(
                                          "Kullanım Koşulları ve Gizlilik Politikası içeriği"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              if (_checkvisibility == true) {
                                                setState(() {

                                                  _checkvisibility = newValue!;
                                                });
                                              }
                                            },
                                            child: Text("Kapat")),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                if (_checkvisibility == false) {
                                                  _checkvisibility = newValue!;
                                                  Navigator.pop(context);
                                                } else {
                                                  _checkvisibility = newValue!;
                                                }
                                              });
                                            },
                                            child: Text("Kabul Ediyorum"))
                                      ],
                                    );
                                  });
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        )),
                  ),
                ]),
          ),
        ));
  }
}
