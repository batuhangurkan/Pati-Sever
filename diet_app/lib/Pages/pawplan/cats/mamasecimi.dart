import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MamaSecimi extends StatefulWidget {
  const MamaSecimi({super.key});

  @override
  State<MamaSecimi> createState() => _MamaSecimiState();
}

class _MamaSecimiState extends State<MamaSecimi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kedilerde Mama Seçimi?',
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
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 8,
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.deepOrangeAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Yavru Kedilerde Mama Seçimi?"),
            leading: FaIcon(
              FontAwesomeIcons.cat,
              color: Colors.deepOrangeAccent,
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.deepOrangeAccent,
            ),
            onTap: () {
              Navigator.pushNamed(context, 'yavrukedimama');
            },
          ),
          ListTile(
            title: Text("Kedinin Yaşına Göre Mama Seçimi?"),
            leading: FaIcon(
              FontAwesomeIcons.cat,
              color: Colors.deepOrangeAccent,
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.deepOrangeAccent,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text("Kedilere Hangi Marka Mama Verilmeli?"),
            leading: FaIcon(
              FontAwesomeIcons.cat,
              color: Colors.deepOrangeAccent,
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.deepOrangeAccent,
            ),
            onTap: () {
              Navigator.pushNamed(context, 'hangimama');
            },
          ),
        ],
      ),
    );
  }
}
