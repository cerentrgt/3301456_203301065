import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_notebook/MyBackGround/DreamBackground.dart';
import 'package:memory_notebook/data/DreamDbHelper.dart';
import 'package:memory_notebook/models/DreamModel.dart';

class DreamAdd extends StatefulWidget {
  const DreamAdd({Key? key}) : super(key: key);

  @override
  State<DreamAdd> createState() => _DreamAddState();
}

class _DreamAddState extends State<DreamAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HAYALLERİNİ EKLE"),
        backgroundColor: Colors.indigo[300],
      ),
      body: DreamsBody(),
    );
  }
}

class DreamsBody extends StatelessWidget {
  var dbHelper = DreamDbHelper();
  var txtName = TextEditingController();
  var txtDescriptions = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.deepPurpleAccent,
      padding: EdgeInsets.symmetric(horizontal: 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
    );
    return DreamBackground(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "HAYAL OLUŞTUR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepPurpleAccent),
              ),
              buildNameField(),
              SizedBox(height: size.height * 0.03),
              buildDescriptionsField(),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: style,
                    child: const Text(
                      "KAYDET",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      var result = dbHelper.insert(DreamModel(
                          name: txtName.text,
                          descriptions: txtDescriptions.text));
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: const InputDecoration(labelText: "HAYALİNİN ADI NEDİR?"),
      textCapitalization: TextCapitalization.words,
      maxLength: 40,
      controller: txtName,
    );
  }

  buildDescriptionsField() {
    return TextField(
      decoration: const InputDecoration(labelText: "HAYALİN NEDİR?"),
      textCapitalization: TextCapitalization.words,
      controller: txtDescriptions,
    );
  }
}
