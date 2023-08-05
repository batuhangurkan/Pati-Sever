import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Giriş yap
  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.user;
  }

  //Çıkış Yap Fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

  //Kayıt ol fonksiyonu
  Future<User?> createPerson(String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firestore.collection("Person").doc(user.user!.uid).set({
      "email": email,
      "password": password,
    });

    return user.user;
  }
}
