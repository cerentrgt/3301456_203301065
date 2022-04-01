import 'package:flutter/material.dart';

import '../../../MyBackGround/MyBackground.dart';
import '../../../data/CalendarDbHelper.dart';
import '../../../models/Calendar.dart';

class PlansAdd extends StatefulWidget {
  const PlansAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<PlansAdd> createState() => _PlansAddState();
}

class _PlansAddState extends State<PlansAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PLAN EKLE"),
        backgroundColor: Colors.indigo[300],
      ),
      body: PlansAddBody(),
    );
  }
}

class PlansAddBody extends StatelessWidget {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();


  var dbHelper = CalendarDbHelper();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyBackGround(
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "PLAN OLUŞTURMA",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepPurpleAccent),
              ),
              SizedBox(height: size.height * 0.03),
              buildNameField(),
              SizedBox(height: size.height * 0.03),
              buildDescriptionField(),
              SizedBox(height: size.height * 0.03),
              yesOrNoButton(context),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
          labelText: "Plan ismi nedir?",
          counterStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
      controller: nameController,
    );
  }


  Widget buildDescriptionField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
          labelText: "Planın nedir?",
          counterStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
      controller: descriptionController,
    );
  }

  Widget yesOrNoButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "VAZGEÇ",
            style: TextStyle(
              color: Colors.deepPurpleAccent[200],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            var result = dbHelper.insert(Calendar(
              name: nameController.text,
              descriptions: descriptionController.text,

            ));
            Navigator.pop(context, true);
          },
          child: Text(
            "EKLE",
            style: TextStyle(
              color: Colors.deepPurpleAccent[400],
            ),
          ),
        ),
      ],
    );
  }
}
