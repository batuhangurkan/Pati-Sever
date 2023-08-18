import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SatinAlma extends StatefulWidget {
  const SatinAlma({super.key});

  @override
  State<SatinAlma> createState() => _SatinAlmaState();
}

class _SatinAlmaState extends State<SatinAlma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Satın Alma Geçmişi',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;
                  if (ConnectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        final person = data[index].data();
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(child: Text(person['title'])),
                          ],
                        );
                      });
                },
                stream: FirebaseFirestore.instance
                    .collection("PurshaceHistory")
                    .snapshots(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
