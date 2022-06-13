import 'package:flutter/material.dart';
import '../../MyBackGround/MyDrawer.dart';
import 'TableCalendarPage.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Planlama"),backgroundColor: Colors.indigo[300]),
      drawer: MyDrawer(),
      body: TableCalendarPage(),

    );
  }
}
