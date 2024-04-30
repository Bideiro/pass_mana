import 'package:flutter/material.dart';
import 'package:pass_mana/models/profile.dart';
import 'package:pass_mana/screens/profile_tile.dart';
import 'package:provider/provider.dart';

class Proflist extends StatefulWidget {
  @override
  _brewlistState createState() => _brewlistState();
}

class _brewlistState extends State<Proflist> {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<List<Profiles?>?>(context) ?? [];
    return ListView.builder(
      itemCount: profile?.length,
      itemBuilder: (context, index) {
        return ProfileTile(userprofiles: profile![index]);
      },
    );
  }
}
