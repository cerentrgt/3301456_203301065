import 'package:flutter/material.dart';

import '../../MyBackGround/MyDrawer.dart';
import 'Screens/SettingsScreens.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("AYARLAR"),
        backgroundColor: Colors.indigo[300],
      ),
      body: SettingsScreens(),
    );
  }
}
