import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pass_mana/database.dart';
import 'package:pass_mana/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CUser? _UserfromFB(User user) {
    return CUser(uid: user.uid);
  }

  Stream<CUser?> get user {
    return _auth.authStateChanges().map((User? user) => _UserfromFB(user!));
  }

  Future reg(String name, String email, String pass,) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      User? user = result.user;
      await Dbservice(uid: user!.uid)
          .regdbupdate( name);
      return _UserfromFB(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> signIn(String email, String pass) async {
    try {
      // UserCredential result =
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }



  





  void _changePassword(String password) async {
    User user = FirebaseAuth.instance.currentUser!;
    String newPassword = password;
    user.updatePassword(newPassword).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
}
