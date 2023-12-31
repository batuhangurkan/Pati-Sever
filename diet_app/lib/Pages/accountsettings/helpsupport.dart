import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yardım ve Destek',
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
        children: [
          ExpansionTile(
            leading: FaIcon(
              FontAwesomeIcons.questionCircle,
              color: Colors.deepOrangeAccent,
            ),
            title: Text(
              'Pati Sever Nasıl Kullanılır?',
              style: GoogleFonts.ubuntu(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.deepOrangeAccent,
            ),
            children: [
              Text(
                  "Pati Sever bir hayvansever rehber uygulamasıdır. Uygulamada sizlerin öğrenmek istediği bilgilerden tutun, hayvanlar için bağış yapabileceğiniz bir sistem bile bulunmaktadır. Bu uygulama insanların patili dostlarımız hakkında bilgilenmesi için gönüllü olarak yapılmıştır.")
            ],
          ),
          ExpansionTile(
            leading: FaIcon(
              FontAwesomeIcons.creditCard,
              color: Colors.deepOrangeAccent,
            ),
            title: Text(
              'Yaptığım Bağışlar Nereye Gidiyor?',
              style: GoogleFonts.ubuntu(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.deepOrangeAccent,
            ),
            children: [
              Text(
                  "Yaptığınız bağışlar, hayvanlar için gerekli olan malzemelerin alınması için kullanılmaktadır. Bu malzemeler, hayvan barınaklarına, sokak hayvanlarına ve hayvanseverlere ulaştırılmaktadır. Yaptığınız bütün bağışlar videolar ile belgelenmektedir. Bağışlarınızın nereye gittiğini görmek için bağışlarım sayfasına gidebilirsiniz.")
            ],
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.circleInfo,
              color: Colors.deepOrangeAccent,
            ),
            title: Text(
              'Veri Politikası',
              style: GoogleFonts.ubuntu(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.deepOrangeAccent,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.info,
              color: Colors.deepOrangeAccent,
            ),
            title: Text(
              'Gizlilik Politikası',
              style: GoogleFonts.ubuntu(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.deepOrangeAccent,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
