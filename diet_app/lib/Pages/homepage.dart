import 'package:diet_app/services/auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isDarkMode = false;
  bool isNotification = false;

  @override
  void initState() {
    _loadSwitchValue();
    super.initState();
  }

  void _loadSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    Future updateDisplayName(String newDisplayName) async {
      var user = await FirebaseAuth.instance.currentUser;
      user!.updateDisplayName(newDisplayName);
    }

    final User? user = FirebaseAuth.instance.currentUser;
    AuthService _authService = AuthService();
    return Scaffold(
        appBar: AppBar(
          title: Text('Ana Sayfa',
              style: GoogleFonts.ubuntu(
                fontSize: 20,
                color: Colors.black,
              )),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed('settings');
              },
              color: Colors.black,
            ),
          ],
          leading: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 15,
              ),
              CircleAvatar(
                  backgroundImage: AssetImage("assets/images/cat_3382653.png"),
                  radius: 20,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 900.0,
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                  ),
                                  CircleAvatar(
                                      backgroundImage: AssetImage(
                                          user?.photoURL ??
                                              "assets/images/cat_3382653.png"),
                                      radius: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 60, top: 75),
                                        child: IconButton(
                                          icon: Icon(Icons.camera_alt),
                                          onPressed: () {},
                                          color: Colors.black,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(user?.email ?? "",
                                      style: GoogleFonts.ubuntu(
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      user?.emailVerified == true
                                          ? "E-posta Doğrulanmış ✅"
                                          : "E-posta Doğrulanmamış ❌",
                                      style: GoogleFonts.ubuntu(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal)),
                                  if (user?.emailVerified == false) ...[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        user!.sendEmailVerification();
                                        IconSnackBar.show(
                                          context: context,
                                          label:
                                              "E-posta doğrulama linki gönderildi.",
                                          snackBarType: SnackBarType.save,
                                          duration: Duration(seconds: 3),
                                        );
                                      },
                                      child: Text(
                                        "E-posta doğrulama linki gönder",
                                        style: GoogleFonts.ubuntu(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(
                                            15.0), //content padding inside button
                                        primary: const Color.fromARGB(
                                            255, 8, 197, 119),
                                        shape: StadiumBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.grey[200],
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.person),
                                        title: Text('Hesap Ayarları'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('accountsettings');
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.grey[200],
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.history),
                                        title: Text('Satın Alma Geçmişi'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.grey[200],
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.info),
                                        title: Text('Hakkında'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.grey[200],
                                      ),
                                      child: ListTile(
                                        leading:
                                            Icon(Icons.help_center_rounded),
                                        title: Text('Yardım & Destek'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.grey[200],
                                      ),
                                      child: ListTile(
                                          leading: Icon(Icons.sunny_snowing),
                                          title: Text('Tema Seçimi'),
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
                                            onChanged: (newValue) {
                                              setState(() {
                                                if (isDarkMode == true) {
                                                  isDarkMode = newValue;
                                                  _saveTheme(newValue);
                                                  ThemeManager.of(context)
                                                      .setBrightnessPreference(
                                                          BrightnessPreference
                                                              .light);
                                                } else {
                                                  isDarkMode = newValue;
                                                  _saveTheme(newValue);
                                                  ThemeManager.of(context)
                                                      .setBrightnessPreference(
                                                          BrightnessPreference
                                                              .dark);
                                                }
                                              });
                                            },
                                            activeTrackColor: Colors.green,
                                            activeColor: Colors.white,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.grey[200],
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.exit_to_app),
                                        title: Text('Çıkış Yap'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text("Çıkış Yap"),
                                                    content: Text(
                                                        "Çıkış yapmak istediğinize emin misiniz?"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text("Hayır")),
                                                      TextButton(
                                                          onPressed: () {
                                                            IconSnackBar.show(
                                                              context: context,
                                                              label:
                                                                  "Çıkış yapılan hesap: ${user?.email}",
                                                              snackBarType:
                                                                  SnackBarType
                                                                      .save,
                                                            );
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            _authService
                                                                .signOut();
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamedAndRemoveUntil(
                                                                    'login',
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false);
                                                          },
                                                          child: Text("Evet"))
                                                    ],
                                                  ));
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.grey[200],
                                      ),
                                      child: ListTile(
                                        leading:
                                            Icon(Icons.delete_forever_rounded),
                                        title: Text('Hesabımı Sil'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {},
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ))
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 5.0,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color.fromARGB(255, 245, 209, 154),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/cat_1864640.png",
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Günlük Bağışlanan Mama Miktarı:" + "",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircleProgressBar(
                        foregroundColor: Colors.orange,
                        value: 1,
                        child: AnimatedCount(
                          count: 1,
                          unit: '%',
                          duration: Duration(seconds: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Hedef: 100 kg",
                        style: GoogleFonts.ubuntu(
                          color: Colors.black,
                          fontSize: 15,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 5.0,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color.fromARGB(255, 245, 209, 154),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/cat_1864640.png",
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Günlük Bağışlanan Mama Miktarı:" + "",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircleProgressBar(
                        foregroundColor: Colors.orange,
                        value: 1,
                        child: AnimatedCount(
                          count: 1,
                          unit: '%',
                          duration: Duration(seconds: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Hedef: 100 kg",
                        style: GoogleFonts.ubuntu(
                          color: Colors.black,
                          fontSize: 15,
                        )),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
