import 'package:diet_app/services/testservice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 8, 197, 119),
            child: FaIcon(FontAwesomeIcons.plus),
            onPressed: () {}),
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.white,
            overlayColor: MaterialStateProperty.all(Colors.white),
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                  icon: FaIcon(FontAwesomeIcons.dumbbell, color: Colors.white),
                  text: 'Egzersizler'),
              Tab(
                icon: FaIcon(FontAwesomeIcons.calendar, color: Colors.white),
                text: 'Programlarım',
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 8, 197, 119),
          centerTitle: true,
          title: Text('Fitness & Egzersiz',
              style: GoogleFonts.ubuntu(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        body: TabBarView(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.dumbbell),
                        title: Text('Ön Kol Egzersizleri'),
                        subtitle: Text(
                            'Ön kol için yapılan egzersizleri görmek için tıklayınız.'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.dumbbell),
                        title: Text('Arka Kol Egzersizleri'),
                        subtitle: Text(
                            'Arka kol için yapılan egzersizleri görmek için tıklayınız.'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.dumbbell),
                        title: Text('Gögüs Egzersizleri'),
                        subtitle: Text(
                            'Gögüs için yapılan egzersizleri görmek için tıklayınız.'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.dumbbell),
                        title: Text(
                          'Sırt Egzersizleri',
                        ),
                        subtitle: Text(
                            'Sırt için yapılan egzersizleri görmek için tıklayınız.'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.dumbbell),
                        title: Text('Omuz Egzersizleri'),
                        subtitle: Text(
                            'Omuz için yapılan egzersizleri görmek için tıklayınız.'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.dumbbell),
                        title: Text('Bacak Egzersizleri'),
                        subtitle: Text(
                            'Bacak için yapılan egzersizleri görmek için tıklayınız.'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ])),
            Container(
                child: Center(
              child: Text(
                "Programlarım",
              ),
            )),
          ],
        ),
      ),
    );
  }
}
