import 'package:flutter/material.dart';
import 'package:memory_notebook/data/dbHelper.dart';
import '../../../MyBackGround/MyBackground.dart';
import '../../../models/MemoryItemModel.dart';

class MemoryAdd extends StatefulWidget {
  const MemoryAdd({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemoryAddState();
}

class _MemoryAddState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ANI EKLE"),
        backgroundColor: Colors.indigo[300],
      ),
      body: MemoryAddBody(),
    );
  }
}

class MemoryAddBody extends StatelessWidget {
  var dbHelper = DbHelper();
  var txtname = TextEditingController();
  var txtMostRecentText = TextEditingController();
  var txtdate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.deepPurpleAccent,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6),),
      ),
    );

    return MyBackGround(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "ANI OLUŞTUR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,color: Colors.deepPurpleAccent),
              ),
              buildDateField(),
              SizedBox(height: size.height * 0.03),
              buildNameField(),
              SizedBox(height: size.height * 0.03),
              buildMostRecentTextField(),
              SizedBox(height: size.height * 0.03),
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
                  var result = dbHelper.insert(MemoryItemModel(
                      name: txtname.text,
                      mostRecentText: txtMostRecentText.text,
                      date: txtdate.text));
                  Navigator.pop(context, true);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration:
          const InputDecoration(labelText: "GÜNÜN ÖNEMİNİ ANLATAN İSMİ"),
      textCapitalization: TextCapitalization.words,
      maxLength: 40,
      controller: txtname,
    );
  }

  buildDateField() {
    return TextField(
      decoration: const InputDecoration(labelText: "GÜNÜN TARİHİ"),
      keyboardType: TextInputType.datetime,
      controller: txtdate,
    );
  }

  buildMostRecentTextField() {
    return TextField(
      decoration:
          const InputDecoration(labelText: "YAZMAK İSTEDİĞİN ANIN NEDİR?"),
      textCapitalization: TextCapitalization.words,
      controller: txtMostRecentText,
    );
  }
}
