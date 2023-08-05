import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 197, 119),
        centerTitle: true,
        title: Text('Yeni Paylaşım',
            style: GoogleFonts.ubuntu(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
