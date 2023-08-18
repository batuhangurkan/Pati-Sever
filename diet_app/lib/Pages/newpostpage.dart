import 'package:diet_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_manager/theme_manager.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  User? user = FirebaseAuth.instance.currentUser;
  AuthService _authService = AuthService();
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Rehber',
              style: GoogleFonts.ubuntu(
                fontSize: 20,
                color: Colors.black,
              )),
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.shieldCat,
                    color: Colors.deepOrangeAccent,
                  ),
                  onPressed: () {},
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.gift,
                    color: Colors.green,
                  ),
                  onPressed: () {},
                ))
          ],
          leading: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 13,
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
                                    height: 20,
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
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('purchasehistory');
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
                                        leading: Icon(Icons.info),
                                        title: Text('Hakkında'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('appabout');
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
                                            Icon(Icons.help_center_rounded),
                                        title: Text('Yardım & Destek'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('helpsupport');
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
                                  ],
                                  if (user?.emailVerified == true) ...[
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
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('purchasehistory');
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
                                        leading: Icon(Icons.info),
                                        title: Text('Hakkında'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('appabout');
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
                                            Icon(Icons.help_center_rounded),
                                        title: Text('Yardım & Destek'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('helpsupport');
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
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: Text("Pati Sever V0.0.1 🐱"),
                                    )
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
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Pati Özel Rehber",
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/cat_2173478.png"),
              ),
              title: Text("Kedilere Nasıl Davranılmalı?",
                  style: GoogleFonts.ubuntu(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text("Kıbrıs Kedisi",
                  style: GoogleFonts.ubuntu(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  )),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).pushNamed('guide1');
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    AssetImage("assets/images/bandage_10551389.png"),
              ),
              title: Text("Mama Seçimi Nasıl Olmalı?",
                  style: GoogleFonts.ubuntu(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text("Kıbrıs Kedisi",
                  style: GoogleFonts.ubuntu(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  )),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/paw_2865755.png"),
              ),
              title: Text("Kediye sevgi nasıl gösterilir?",
                  style: GoogleFonts.ubuntu(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text("Kıbrıs Kedisi",
                  style: GoogleFonts.ubuntu(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  )),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/toilet_2372879.png"),
              ),
              title: Text("Kediler Yıkanır Mı?",
                  style: GoogleFonts.ubuntu(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text("Kıbrıs Kedisi",
                  style: GoogleFonts.ubuntu(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  )),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Sıkça Sorulan Sorular",
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/cat_2173478.png"),
              ),
              title: Text("Kedilere Nasıl Davranılmalı?",
                  style: GoogleFonts.ubuntu(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text("Kıbrıs Kedisi",
                  style: GoogleFonts.ubuntu(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  )),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    AssetImage("assets/images/bandage_10551389.png"),
              ),
              title: Text("Mama Seçimi Nasıl Olmalı?",
                  style: GoogleFonts.ubuntu(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text("Kıbrıs Kedisi",
                  style: GoogleFonts.ubuntu(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  )),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color.fromARGB(255, 218, 113, 81)),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.of(context).pushNamed('guide1');
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                      "Bu rehberi geliştirmek ve patili dostlarımıza daha çok yardımcı olabilmek için bize katılın!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            )
          ],
        ));
  }
}
