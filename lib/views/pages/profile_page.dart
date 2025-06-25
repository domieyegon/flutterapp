import 'package:flutter/material.dart';
import 'package:flutterapp/data/notifiers.dart';
import 'package:flutterapp/views/pages/welcome_page.dart';

import '../../widgets/hero_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage("assets/images/logo.png"),
          ),
          ListTile(
            onTap: () {
              selectedPageNotifier.value =0;
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage()),
            );
            },
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
