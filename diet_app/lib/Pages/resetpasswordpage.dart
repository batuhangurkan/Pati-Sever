import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
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
                  onPressed: () {
                    var snackBar = SnackBar(
                      content: Text("Giriş Yapıldı"),
                      duration: Duration(seconds: 2, milliseconds: 500),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Future.delayed(Duration(seconds: 2), () {});
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '', (Route<dynamic> route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.all(15.0), //content padding inside button
                    primary: Color.fromARGB(255, 2, 187, 79),
                    shape: StadiumBorder(),
                  ),
                  child: Text('Şifremi Sıfırla')),
            ),
          ],
        ),
      ),
    );
  }
}
