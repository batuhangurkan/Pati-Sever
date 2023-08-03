import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Egzersizler',
            style: GoogleFonts.ubuntu(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
          crossAxisSpacing: 5,
          mainAxisSpacing: 15,
          crossAxisCount: 2,
          children: [
            Container(
              child: Card(
                color: Color(0xFFF5CEB8),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/karın.png',
                      height: 150,
                      width: 150,
                    ),
                    Text(
                      'Karın Kası',
                      style: GoogleFonts.ubuntu(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                color: Color(0xFFF5CEB8),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/omuz.png',
                      height: 150,
                      width: 150,
                    ),
                    Text(
                      'Sırt Kası',
                      style: GoogleFonts.ubuntu(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                color: Color(0xFFF5CEB8),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/gogus.png',
                      width: 150,
                      height: 150,
                    ),
                    Text(
                      'Göğüs Kası',
                      style: GoogleFonts.ubuntu(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                color: Color(0xFFF5CEB8),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/gogus.png',
                      width: 150,
                      height: 150,
                    ),
                    Text(
                      'Bacak Kası',
                      style: GoogleFonts.ubuntu(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                color: Color(0xFFF5CEB8),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/gogus.png',
                      width: 150,
                      height: 150,
                    ),
                    Text(
                      'Omuz Kası',
                      style: GoogleFonts.ubuntu(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                color: Color(0xFFF5CEB8),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/gogus.png',
                      width: 150,
                      height: 150,
                    ),
                    Text(
                      'Kol Kası',
                      style: GoogleFonts.ubuntu(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
