import 'package:diet_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    Future _resetPassword(String email) async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        Future.delayed(Duration(seconds: 1), () {});
        SnackBar snackBar = SnackBar(
          content: Text("Şifre sıfırlama maili gönderildi."),
          duration: Duration(seconds: 2),
        );
      } catch (e) {
        print(e);
      }
    }

    AuthService _authService = AuthService();
    ScrollController _scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 120,
              ),
              Center(
                child: Image.asset(
                  'assets/images/loading.png',
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(
                height: 75,
              ),
              Text('My-Diet-App Şifremi Unuttum Sayfası,',
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'E-Posta Adresiniz',
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
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.6,
                child: ElevatedButton(
                  child: Text('Şifremi Sıfırla'),
                  onPressed: () {
                    if (_emailController.text.isNotEmpty) {
                      _resetPassword(_emailController.text.trim());
                      IconSnackBar.show(
                        snackBarType: SnackBarType.save,
                        context: context,
                        label: "Şifre sıfırlama maili gönderildi." +
                            _emailController.text.trim(),
                        duration: Duration(seconds: 3),
                      );
                      _emailController.clear();
                    } else {
                      IconSnackBar.show(
                        snackBarType: SnackBarType.fail,
                        context: context,
                        label: "Lütfen bir e-posta adresi giriniz.",
                        duration: Duration(seconds: 3),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.all(15.0), //content padding inside button
                    primary: Color.fromARGB(255, 8, 197, 119),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
