import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class YavruKediMama extends StatefulWidget {
  const YavruKediMama({super.key});

  @override
  State<YavruKediMama> createState() => _YavruKediMamaState();
}

class _YavruKediMamaState extends State<YavruKediMama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yavru Kedilerde Mama Seçimi?',
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
      body: Container(
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.network(person['image']),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Text(
                              person['desc'],
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white, fontSize: 20),
                            )),
                      ],
                    ),
                  );
                });
          },
          stream: FirebaseFirestore.instance
              .collection("KedilerdeMamaSecimi")
              .snapshots(),
        ),
      ),
    );
  }
}
