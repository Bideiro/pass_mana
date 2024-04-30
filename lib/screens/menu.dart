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
                    title: Text('refresh'),
                    onTap: () async {
                      setState(() {});
                      ();
                    },
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

// class CardListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: const [
//           CardItem(
//             title: 'Card 1',
//             subtitle: 'Subtitle for Card 1',
//             icon: Icons.account_circle,
//           ),
//           CardItem(
//             title: 'Card 2',
//             subtitle: 'Subtitle for Card 2',
//             icon: Icons.shopping_cart,
//           ),
//           CardItem(
//             title: 'Card 3',
//             subtitle: 'Subtitle for Card 3',
//             icon: Icons.mail,
//           ),
//           // Add more CardItem widgets for additional cards
//         ],
//       ),
//     );
//   }
// }

// Widget CardListPage() {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:_buildList()
//     );
//   }
// }

// Widget CardItem() {

//   final String title;
//   final String subtitle;
//   final IconData icon;

//     @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: ListTile(
//         leading: Icon(icon),
//         title: Text(title),
//         subtitle: Text(subtitle),
//         onTap: () {
//           // Handle tap on the card
//         },
//       ),
//     );
//   }
// }

// Widget _buildList() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('Profiles').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text('error');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text('loading...');
//         }

//         return ListView(
//           children: snapshot.data!.docs
//               .map<Widget>((doc) => _buildcard(doc))
//               .toList(),
//         );
//       },
//     );
//   }

//  Widget _buildcard(DocumentSnapshot doc) {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.favorite),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: Icon(Icons.share),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: Icon(Icons.more_vert),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Title 1'),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Subtitle 1'),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Description 1'),
//           ),
//         ],
//       ),
//     );
//   }
// }
}
