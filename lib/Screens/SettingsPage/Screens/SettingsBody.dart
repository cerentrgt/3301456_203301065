import 'package:flutter/material.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD1C4E9),
              Color(0xFFB39DDB),
              Color(0xFF9575CD),
              Color(0xFF7E57C2),
            ]),
      ),
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Daha Yapım Aşamasındadır.",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),




        ],
      ),
    );
  }
}
