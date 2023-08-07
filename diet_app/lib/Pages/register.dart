import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_app/Pages/login.dart';
import 'package:diet_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final currentUser = FirebaseAuth.instance;
  bool _visibility = false;
  bool _visibility2 = false;
  bool _checkvisibility = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordAgainController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
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
                    height: 120,
                  ),
                  Text("Kayıt Sayfası,",
                      style: GoogleFonts.rubik(
                          color: Colors.black87,
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
                            color: Colors.grey[600],
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
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        hintStyle: GoogleFonts.ubuntu(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
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
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintStyle: GoogleFonts.ubuntu(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
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
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      obscureText: _visibility,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _visibility
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
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
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      obscureText: _visibility2,
                      controller: _passwordAgainController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _visibility2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {
                            setState(() {
                              _visibility2 = !_visibility2;
                            });
                          },
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        hintStyle: GoogleFonts.ubuntu(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty &&
                              _passwordAgainController.text.isNotEmpty &&
                              _usernameController.text.isNotEmpty) {
                            setState(() {
                              _authService
                                  .createPerson(
                                      _emailController.text,
                                      _passwordController.text,
                                      _usernameController.text)
                                  .then((value) {});
                              IconSnackBar.show(
                                  duration: Duration(seconds: 3),
                                  context: context,
                                  snackBarType: SnackBarType.save,
                                  label: 'Başarılı bir şekilde kayıt oldunuz!');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            });
                          } else {
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
                          primary: Color.fromARGB(255, 2, 187, 79),
                          shape: StadiumBorder(),
                        ),
                        child: Text('Kayıt Ol')),
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
                        child: CheckboxListTile(
                          title: Text(
                            "Kullanım Koşulları ve Gizlilik Politikası Okudum Kabul ediyorum",
                            style: GoogleFonts.ubuntu(
                                fontSize: 15,
                                color: Colors.grey[600],
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
                                              if (_checkvisibility == false) {
                                                setState(() {
                                                  _checkvisibility = newValue!;
                                                });
                                              }
                                            },
                                            child: Text("Kapat")),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                if (_checkvisibility == true) {
                                                  _checkvisibility = newValue!;
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
