import 'package:flutter/material.dart';
import 'package:memory_notebook/Screens/PlanPage/TableCalendarPage.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendarPage(),
    );
  }
}
