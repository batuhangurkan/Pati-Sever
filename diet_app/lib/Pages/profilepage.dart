import 'package:diet_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diet_app/services/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    AuthService _authService = AuthService();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 8, 197, 119),
          centerTitle: true,
          title: Text('Profil',
              style: GoogleFonts.ubuntu(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Center(
            child: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                radius: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 60, top: 75),
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Text(user?.displayName ?? "",
              style: GoogleFonts.ubuntu(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 5,
          ),
          Text(user?.email ?? "",
              style: GoogleFonts.ubuntu(
                fontSize: 15,
                color: Colors.grey[500],
              )),
          Text(user?.emailVerified == true
              ? "Doğrulanmış Hesap"
              : "Doğrulanmamış Hesap"),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 45,
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Premium'a Yükselt"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15.0), //content padding inside button
                primary: const Color.fromARGB(255, 8, 197, 119),
                shape: StadiumBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.grey[900],
            ),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Hesap Ayarları'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.grey[900],
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
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.grey[900],
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
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.grey[900],
            ),
            child: ListTile(
              leading: Icon(Icons.help_center_rounded),
              title: Text('Yardım & Destek'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.grey[900],
            ),
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Çıkış Yap'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                IconSnackBar.show(
                    context: context,
                    label: "Başarıyla çıkış yapıldı!",
                    snackBarType: SnackBarType.alert,
                    duration: Duration(seconds: 3));
                _authService.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'login', (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
