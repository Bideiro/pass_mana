import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pass_mana/database.dart';
import 'package:pass_mana/models/user.dart';
import 'package:pass_mana/screens/login.dart';
import 'package:pass_mana/screens/menu.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    final CUser? user = Provider.of<CUser?>(context);
    print(user);
    if (user == null) {
      print("going to login");
      return LoginApp();
    } else {
      print("going to home");
      return StreamProvider<DocumentSnapshot<Object?>?>.value(
          value: Dbservice(uid: user.uid).usersdatas,
          initialData: null,
          child: Menu());
    }
  }
}
