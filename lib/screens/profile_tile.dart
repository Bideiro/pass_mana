import 'dart:convert';

import 'package:dart_des/dart_des.dart';
import 'package:flutter/material.dart';
import 'package:pass_mana/database.dart';
import 'package:pass_mana/models/profile.dart';
import 'package:pass_mana/models/user.dart';
import 'package:pass_mana/screens/del_button.dart';
import 'package:pass_mana/screens/edit_profile.dart';
import 'package:provider/provider.dart';

class ProfileTile extends StatelessWidget {
  final Profiles? userprofiles;

  ProfileTile({required this.userprofiles});

  

  @override
  Widget build(BuildContext context) {
    final CUser? user = Provider.of<CUser?>(context);

    String currtitle = userprofiles?.title ?? "No title";
    String curremail = userprofiles?.encryptedemail ?? "No Email";
    String currpass = userprofiles?.encryptedpass ?? "No Password";
    String docuid = userprofiles?.docuid ?? "No DocumentID";

    String key = userprofiles?.key ?? "00000000";
    List<int> decrypted;

    DES desECB = DES(key: key.codeUnits, mode: DESMode.ECB);

    try {
      decrypted = desECB.decrypt(base64.decode(curremail));

      curremail = utf8.decode(decrypted);
    } catch (e) {
      print(e.toString());
    }

    if (currpass != "No Password") {
      decrypted = desECB.decrypt(base64.decode(currpass));

      currpass = utf8.decode(decrypted);
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile(
                              pastemail: curremail,
                              pastkey: key,
                              pastpass: currpass,
                              pasttitle: currtitle,
                              docuid: docuid,
                            )),
                  );
                },
              ),
              DeleteConfirmationButton(
                onPressed: () async {
                  await Dbservice(uid: user!.uid).delprofile(docuid);
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              currtitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Email:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              curremail,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Password:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              currpass,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
