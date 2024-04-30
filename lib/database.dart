import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_des/dart_des.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pass_mana/models/profile.dart';

class Dbservice {
  final String? uid;
  Dbservice({this.uid});

  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference userCollec =
      FirebaseFirestore.instance.collection("userdata");

  Future regdbupdate(
      String name) async {
    return await userCollec.doc(uid).set(
        { 'name': name});
  }

  Future<void> addprofile(
      String title, String email, String pass, String key) async {
    DES desECB = DES(key: key.codeUnits, mode: DESMode.ECB);

    List<int> encrypted;

    encrypted = desECB.encrypt(pass.codeUnits);
    String encryptedpass = base64.encode(encrypted);

    encrypted = desECB.encrypt(email.codeUnits);
    String encryptedemail = base64.encode(encrypted);

    final Document = userCollec.doc(uid).collection('Profiles').doc();

    await userCollec.doc(uid).collection("Profiles").doc(Document.id).set({
      'docuid': Document.id,
      'key': key,
      'title': title,
      'encryptedemail': encryptedemail,
      'encryptedpass': encryptedpass,
    });
  }

  Future<void> EditProfile(String title, String email, String pass, String key,
      String docuid) async {
    DES desECB = DES(key: key.codeUnits, mode: DESMode.ECB);

    List<int> encrypted;

    encrypted = desECB.encrypt(pass.codeUnits);
    String encryptedpass = base64.encode(encrypted);

    encrypted = desECB.encrypt(email.codeUnits);
    String encryptedemail = base64.encode(encrypted);

    await userCollec.doc(uid).collection("Profiles").doc(docuid).set({
      'docuid': docuid,
      'key': key,
      'title': title,
      'encryptedemail': encryptedemail,
      'encryptedpass': encryptedpass,
    });
  }

  Future<void> delprofile(String docuid) async {
    FirebaseFirestore.instance
        .collection("userdata")
        .doc(uid)
        .collection('Profiles')
        .doc(docuid)
        .delete();
  }

  Stream<List<Profiles?>?> get profiles {
    return userCollec
        .doc(uid)
        .collection('Profiles')
        .snapshots()
        .map(_profileslistFromSnapshot);
  }

  List<Profiles> _profileslistFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Profiles(
        docuid: doc.get('docuid'),
        key: doc.get('key'),
        title: doc.get('title'),
        encryptedemail: doc.get('encryptedemail'),
        encryptedpass: doc.get('encryptedpass'),
      );
    }).toList();
  }

  Stream<DocumentSnapshot<Object?>> get usersdatas {
    return userCollec.doc(uid).snapshots();
  }

  Stream<QuerySnapshot> get profilesss {
    return userCollec.doc(uid).collection('Profiles').snapshots();
  }
}
