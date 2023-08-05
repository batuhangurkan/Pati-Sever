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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordAgainController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    'assets/images/loading.png',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Kullanıcı Kayıt Sayfası",
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
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey[400],
                        ),
                        hintText: 'Adınız Soyadınız',
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey[400],
                        ),
                        hintText: 'E-posta',
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
                      obscureText: _visibility,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey[400],
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
                          color: Colors.grey[400],
                        ),
                        hintText: 'Şifrenizi Onaylayın',
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
                                  .createPerson(_emailController.text,
                                      _passwordController.text)
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
                ]),
          ),
        ));
  }
}
