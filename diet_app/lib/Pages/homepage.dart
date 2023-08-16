import 'package:diet_app/Pages/login.dart';
import 'package:diet_app/services/auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickalert/quickalert.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  final List<Map> myGridList = List.generate(2, (index) => {});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    AuthService _authService = AuthService();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Ana Sayfa',
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
                                          ),),
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

                                          ),),
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text("Merhaba, Pati Sever!",
                              style: GoogleFonts.ubuntu(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.20),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('categories');
                            },
                            child: Text("Tümünü Gör", style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SizedBox(
                            width: 15,
                          ),

                          CircleAvatar(

                            backgroundColor: Colors.deepOrangeAccent,
                            radius: 25,

                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.deepOrangeAccent,
                            radius: 25,
                            child: Text(""),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.deepOrangeAccent,
                            radius: 25,
                            child: Text(""),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.deepOrangeAccent,
                            radius: 25,
                            child: Text(""),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.deepOrangeAccent,
                            radius: 25,
                            child: Text(""),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.deepOrangeAccent,
                            radius: 25,
                            child: Text(""),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.deepOrangeAccent,
                            radius: 25,
                            child: Text(""),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.deepOrangeAccent,
                            radius: 25,
                            child: Text(""),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.deepOrangeAccent,
                            radius: 25,
                            child: Text(""),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 6.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.deepOrangeAccent),
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.of(context).pushNamed('mamabagıs');
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                    "Patili dostlarımıza yardım etmek onlarında dışarıdaki yaşamlarına destek olmak istemez misiniz? Daha detaylı bilgi için tıklayınız!",
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
                      ),


                    ),

                    SizedBox(height: 35,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text("Pati Sever Plan Alanı!",
                              style: GoogleFonts.ubuntu(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      //height: MediaQuery.of(context).size.height * 0.95,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.deepOrangeAccent,),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //SizedBox( height: MediaQuery.of(context).size.height * 0.1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 200.0,
                                        color: Colors.white,
                                        child: Center(
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
                                                    CircleAvatar(
                                                      backgroundColor: Colors.deepOrangeAccent,
                                                      radius: 50,
                                                      child: FaIcon(FontAwesomeIcons.cat, color: Colors.white, size: 30,),
                                                    ),



                                                    SizedBox(width: MediaQuery.of(context).size.width * 0.20,),
                                                    CircleAvatar(
                                                      radius: 50,
                                                      backgroundColor: Colors.deepOrangeAccent,
                                                      child: FaIcon(FontAwesomeIcons.dog, color: Colors.white, size: 30,),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget> [
                                                    Row(
                                                      children: [
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.23),
                                                        Text("Kedi", style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold,
                                                        ),),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.37,),
                                                        Text("Köpek", style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold
                                                        ),)
                                                      ],
                                                    )
                                                  ],
                                                )

                                              ]),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.14,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  margin: const EdgeInsets.all(15.0),
                                  padding: const EdgeInsets.all(3.0),

                                  decoration: BoxDecoration(
                                   color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      FaIcon(FontAwesomeIcons.paw, color: Colors.deepOrangeAccent, size: 50,),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Patini Tanı", style: GoogleFonts.ubuntu(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),)
                                    ],
                                  ))

                                ),
                              ),
                             // SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.14,
                                width: MediaQuery.of(context).size.width * 0.35,
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),

                                decoration: BoxDecoration(
                                 color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child:  Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    FaIcon(FontAwesomeIcons.cookie, color: Colors.deepOrangeAccent, size: 50,),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Mama Seçimi?", style: GoogleFonts.ubuntu(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),)
                                  ],
                                ))

                              ),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                            ],
                          ),
                          //SizedBox( height: MediaQuery.of(context).size.height * 0.1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.14,
                                width: MediaQuery.of(context).size.width * 0.25,
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                 color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child:  Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    FaIcon(FontAwesomeIcons.shower, color: Colors.deepOrangeAccent, size: 50,),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Patim Yıkanır Mı?", textAlign: TextAlign.center, style: GoogleFonts.ubuntu(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),)
                                  ],
                                ))
                              ),
                              // SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.14,
                                width: MediaQuery.of(context).size.width * 0.25,
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child:  Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    FaIcon(FontAwesomeIcons.heart, color: Colors.deepOrangeAccent, size: 50,),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Patim İle Spor", textAlign: TextAlign.center, style: GoogleFonts.ubuntu(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),)
                                  ],
                                ))
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.14,
                                width: MediaQuery.of(context).size.width * 0.25,
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                 color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child:  Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    FaIcon(FontAwesomeIcons.dog, color: Colors.deepOrangeAccent, size: 50,),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Diğer Patililer", textAlign: TextAlign.center, style: GoogleFonts.ubuntu(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),)
                                  ],
                                ))
                              ),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                            ],
                          ),
                         //SizedBox( height: MediaQuery.of(context).size.height * 0.1),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
