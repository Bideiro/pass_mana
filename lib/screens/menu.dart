import 'package:flutter/material.dart';
import 'package:pass_mana/auth.dart';
import 'package:pass_mana/database.dart';
import 'package:pass_mana/models/profile.dart';
import 'package:pass_mana/models/user.dart';
import 'package:pass_mana/screens/addprofile.dart';
import 'package:pass_mana/screens/buildprof.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    final CUser? user = Provider.of<CUser?>(context);
    return StreamProvider<List<Profiles?>?>.value(
        value: Dbservice(uid: user!.uid).profiles,
        initialData: null,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Welcome to SecureKey!"),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Add new Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Addprofile()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Log out'),
                    onTap: () async {
                      await auth.signout();
                    },
                  ),
                ],
              ),
            ),
            body: Proflist(),
          );
        });
  }

}
