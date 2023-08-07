import 'package:diet_app/Pages/login.dart';
import 'package:diet_app/Pages/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 150,
              ),
              Container(
                child: Center(
                  child: Text(
                    "Hoşgeldiniz,",
                    style: GoogleFonts.rubik(
                        color: Colors.grey[200],
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Pati Sever uygulamasına hoşgeldiniz. Uygulamayı kullanabilmek için lütfen giriş yapın veya kayıt olun.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/images/birman-cat.png",
                height: 150,
                width: 150,
              ),
              SizedBox(
                height: 150,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'login', (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.all(15.0), //content padding inside button
                      primary: const Color.fromARGB(255, 8, 197, 119),
                      shape: StadiumBorder(),
                    ),
                    child: Text('Giriş Yap')),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'register', (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.all(15.0), //content padding inside button
                      primary: Colors.blue,
                      shape: StadiumBorder(),
                    ),
                    child: Text('Kayıt Ol')),
              ),
            ],
          ),
        ));
  }
}
