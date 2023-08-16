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
    TextEditingController emailController = TextEditingController();
    Future _resetPassword(String email) async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
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
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Center(
                child: Image.asset(
                  'assets/images/birman-cat.png',
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(
                height: 75,
              ),
              Text('Şifremi Unuttum,',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                      "Üzülmenize hiç gerek yok! Şifrenizi yenilemek çok kolay. E-posta adresinizi girin ve şifrenizi yenileyin.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                          fontSize: 15,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.normal)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                    child: Text(
                      "E-posta adresiniz",
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
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.white,),
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
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.6,
                child: ElevatedButton(
                  child: Text('Şifremi Sıfırla', style: GoogleFonts.ubuntu(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),),
                  onPressed: () {
                    if (emailController.text.contains("@") &&
                        emailController.text.isNotEmpty) {
                      _resetPassword(emailController.text.trim());
                      IconSnackBar.show(
                        snackBarType: SnackBarType.save,
                        context: context,
                        label: "Mail gönderildi." + emailController.text.trim(),
                        duration: Duration(seconds: 3),
                      );
                    } else if (emailController.text.isEmpty) {
                      IconSnackBar.show(
                        snackBarType: SnackBarType.fail,
                        context: context,
                        label: "Lütfen bir e-posta adresi giriniz.",
                        duration: Duration(seconds: 3),
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.all(15.0), //content padding inside button
                    primary: Colors.brown[50],
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
