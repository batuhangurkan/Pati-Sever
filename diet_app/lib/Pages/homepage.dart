import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_manager/theme_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false;
    bool isNotification = false;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                image: NetworkImage(
                    "https://raw.githubusercontent.com/abuanwar072/Meditation-App/master/assets/images/undraw_pilates_gpdb.png"),
                fit: BoxFit.cover,
              )),
        ),
        SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                          color: Color(0xFFF2BEA1), shape: BoxShape.circle),
                      child: InkWell(
                        child: Icon(Icons.settings),
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 250,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.sunny,
                                          color: Colors.black),
                                      title: Container(
                                        child: new Text(
                                          'Tema Seçenekleri',
                                          style: GoogleFonts.ubuntu(
                                              color: Colors.black),
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (isDarkMode == true) ...[
                                            Text(
                                              "Aktif Tema Renginiz: Koyu Tema",
                                              style: GoogleFonts.ubuntu(
                                                  color: Colors.black),
                                            ),
                                          ] else ...[
                                            Text(
                                              "Aktif Tema Renginiz: Aydınlık Tema",
                                              style: GoogleFonts.ubuntu(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ],
                                      ),
                                      trailing: Switch(
                                        value: isDarkMode,
                                        onChanged: (value) {
                                          setState(() {
                                            if (isDarkMode == true) {
                                              ThemeManager.of(context)
                                                  .setBrightnessPreference(
                                                      BrightnessPreference
                                                          .light);
                                              isDarkMode = false;
                                            } else {
                                              ThemeManager.of(context)
                                                  .setBrightnessPreference(
                                                      BrightnessPreference
                                                          .dark);
                                              isDarkMode = true;
                                            }
                                          });
                                        },
                                        activeTrackColor: Colors.black,
                                        activeColor: Colors.green,
                                      ),
                                      onTap: () {},
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.notification_add,
                                          color: Colors.black),
                                      title: new Text(
                                        'Bildirim Tercihleri',
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.black),
                                      ),
                                      trailing: Switch(
                                        value: isNotification,
                                        onChanged: (value) {},
                                        activeTrackColor: Colors.black,
                                        activeColor: Colors.green,
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.exit_to_app,
                                          color: Colors.black),
                                      title: new Text(
                                        'Çıkış Yap',
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.black),
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                'login',
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Text("Günaydın, \nKullanıcı",
                      style: GoogleFonts.ubuntu(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 5, 41, 70))),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29.5),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Arama Yapabilirsiniz",
                        hintStyle: TextStyle(color: Colors.black54),
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'excercise');
                      },
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width / 1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://raw.githubusercontent.com/abuanwar072/Meditation-App/master/assets/images/meditation_bg.png"),
                                fit: BoxFit.cover)),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                Colors.black.withOpacity(.9),
                                Colors.black.withOpacity(.3)
                              ])),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Egzersizler",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 10,
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 1,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://raw.githubusercontent.com/abuanwar072/Meditation-App/master/assets/images/meditation_bg.png"),
                              fit: BoxFit.cover)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                              Colors.black.withOpacity(.9),
                              Colors.black.withOpacity(.3)
                            ])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Yiyecek Tercihleri",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
