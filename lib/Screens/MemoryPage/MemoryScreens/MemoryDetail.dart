import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_notebook/MyBackGround/MyBackground.dart';
import 'package:memory_notebook/data/DbHelper.dart';
import 'package:memory_notebook/models/MemoryItemModel.dart';

class MemoryDetail extends StatefulWidget {
  MemoryItemModel memory;

  MemoryDetail({required this.memory, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MemoryDetailState(memory);
  }
}

enum Options { delete, update }

class _MemoryDetailState extends State {
  MemoryItemModel memory;
  _MemoryDetailState(this.memory);

  var dbHelper = DbHelper();
  var txtname = TextEditingController();
  var txtMostRecentText = TextEditingController();
  var txtdate = TextEditingController();

  @override
  void initState() {
    txtname.text = memory.name;
    txtdate.text = memory.date;
    txtMostRecentText.text = memory.mostRecentText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        title: Text("Seçtiğin Anı : ${memory.name}",
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
      body: MyBackGround(
        child: MemoryDetailBody(),
      ),
    );
  }

  MemoryDetailBody() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "SEÇTİĞİN ANININ İÇERİĞİ",
              style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            ),
            buildDateField(),
            SizedBox(height: size.height * 0.03),
            buildNameField(),
            SizedBox(height: size.height * 0.03),
            buildMostRecentTextField(),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(memory.id!);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(MemoryItemModel.withId(
            id: memory.id,
            name: txtname.text,
            mostRecentText: txtMostRecentText.text,
            date: txtdate.text));
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  buildNameField() {
    return TextField(
      decoration: const InputDecoration(
          labelText: "GÜNÜN ÖNEMİNİ ANLATAN İSMİ", hintMaxLines: 15),
      textCapitalization: TextCapitalization.words,
      maxLength: 30,
      controller: txtname,
    );
  }

  buildDateField() {
    return TextField(
      decoration: const InputDecoration(labelText: "GüNÜN TARİHİ"),
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
