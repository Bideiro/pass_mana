import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pass_mana/auth.dart';
import 'package:pass_mana/models/user.dart';
import 'package:pass_mana/screens/auth_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    StreamProvider<CUser?>.value(
      catchError: (_, __) {},
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Authenticate(),
      ),
    ),
  );
}