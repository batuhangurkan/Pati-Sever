import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_manager/theme_manager.dart';

import '../services/auth.dart';
import '../services/wp-api.dart';

class PatiNews extends StatefulWidget {
  const PatiNews({super.key});

  @override
  State<PatiNews> createState() => _PatiNewsState();
}

class _PatiNewsState extends State<PatiNews> {
  String deleteAccount = "delete";
  TextEditingController _deleteAccountController = TextEditingController();
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

  Future refresh() {
    setState(() {
      fetchWpPosts();
    });
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    AuthService _authService = AuthService();
    return RefreshIndicator(
      onRefresh: refresh,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Pati Özel Rehber',
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
                                        ),
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
                                        ),
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
        body: FutureBuilder(
          future: fetchWpPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  Map wppost = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 1, left: 1, right: 1, bottom: 0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(30)),
                         ),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(wppost["_embedded"]
                                ["wp:featuredmedia"][0]["source_url"]),
                          ),
                          title: Text(
                            wppost["title"]["rendered"].replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ""),
                            style: GoogleFonts.ubuntu(
                                fontSize: 15, fontWeight: FontWeight.bold),

                          ),
                          subtitle: InkWell(child: Text("Devamını Görmek İçin Tıklayınız", style: GoogleFonts.ubuntu(color: Colors.grey[500], fontWeight: FontWeight.bold),), onTap: () {},
                          ),

                          onTap: () {},
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container(
              child: ListView.separated(
                itemBuilder: (_, i) {
                  final delay = (i * 300);
                  return Container(
                    decoration: BoxDecoration(
                        color: isDarkMode ? Color(0xff242424) : Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        FadeShimmer.round(
                          size: 60,
                          fadeTheme:
                              isDarkMode ? FadeTheme.dark : FadeTheme.light,
                          millisecondsDelay: delay,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeShimmer(
                              height: 8,
                              width: 150,
                              radius: 4,
                              millisecondsDelay: delay,
                              fadeTheme:
                                  isDarkMode ? FadeTheme.dark : FadeTheme.light,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            FadeShimmer(
                              height: 8,
                              millisecondsDelay: delay,
                              width: 170,
                              radius: 4,
                              fadeTheme:
                                  isDarkMode ? FadeTheme.dark : FadeTheme.light,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                itemCount: 20,
                separatorBuilder: (_, __) => SizedBox(
                  height: 16,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
