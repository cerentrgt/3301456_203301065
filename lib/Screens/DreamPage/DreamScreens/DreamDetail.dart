import 'package:flutter/material.dart';
import 'package:memory_notebook/MyBackGround/DreamBackground.dart';
import 'package:memory_notebook/models/DreamModel.dart';

import '../../../data/DreamDbHelper.dart';

class DreamDetail extends StatefulWidget {
  final DreamModel dream;
  const DreamDetail({Key? key, required this.dream}) : super(key: key);

  @override
  State<DreamDetail> createState() => _DreamDetailState(dream);
}

enum Options { delete, update }

class _DreamDetailState extends State<DreamDetail> {
  DreamModel dream;
  _DreamDetailState(this.dream);

  var dbHelper = DreamDbHelper();
  var txtName = TextEditingController();
  var txtDescriptions = TextEditingController();

  @override
  void initState() {
    txtName.text = dream.name;
    txtDescriptions.text = dream.descriptions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        title: Text("Seçtiğin Hayalin : ${dream.name}",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                color: Colors.white)),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              const PopupMenuItem<Options>(
                textStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo),
                value: Options.delete,
                child: Text("SİL"),
              ),
              const PopupMenuItem<Options>(
                textStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo),
                child: Text("GÜNCELLE"),
                value: Options.update,
              ),
            ],
          ),
        ],
      ),
      body: DreamBackground(
        child: DreamDetailBody(),
      ),
    );
  }

  DreamDetailBody() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 110, 20, 80),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "SEÇTİĞİN HAYALİNİN İÇERİĞİ",
              style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            ),
            SizedBox(height: size.height * 0.04),
            buildNameField(),
            SizedBox(height: size.height * 0.03),
            buildDescriptionsField(),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(dream.id!);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(DreamModel.withId(
          id: dream.id,
          name: txtName.text,
          descriptions: txtDescriptions.text,
        ));
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  buildNameField() {
    return TextField(
      style: TextStyle(
        fontSize: 17,
        fontStyle: FontStyle.italic,
        color: Colors.indigo[900],
      ),
      decoration: const InputDecoration(
        labelText: " HAYALİNİN İSMİ : ",
        hintMaxLines: 15,
        labelStyle: TextStyle(
          fontSize: 19,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w900,
        ),
      ),
      textCapitalization: TextCapitalization.words,
      maxLength: 30,
      controller: txtName,
    );
  }

  buildDescriptionsField() {
    return TextField(
      style: TextStyle(
        fontSize: 17,
        color: Colors.indigo[900],
        fontStyle: FontStyle.italic,
      ),
      decoration: const InputDecoration(
        labelText: "HAYALİN :",
        labelStyle: TextStyle(
          fontSize: 19,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w900,
        ),
      ),
      textCapitalization: TextCapitalization.words,
      controller: txtDescriptions,
    );
  }
}
