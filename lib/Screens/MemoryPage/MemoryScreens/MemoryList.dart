
import 'package:flutter/material.dart';
import 'package:memory_notebook/MyBackGround/MyBackground.dart';
import 'package:memory_notebook/Screens/MemoryPage/MemoryScreens/MemoryAdd.dart';
import 'package:memory_notebook/data/dbHelper.dart';
import 'package:memory_notebook/models/MemoryItemModel.dart';

import 'MemoryDetail.dart';

class MemoryList extends StatefulWidget {
  const MemoryList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemoryListState();
}

class _MemoryListState extends State {
  var dbHelper = DbHelper();

  List<MemoryItemModel>? memories;

  int memoryCount = 0;

  @override
  void initState() {
    getMemory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ANILARIM"),
        backgroundColor: Colors.indigo[300],
      ),
      body: MyBackGround(
        child: MemoryListBody(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[300],
        onPressed: () {
          goToMemoryAdd();
        },
        child: Icon(Icons.add),
        tooltip: "anı ekle",
      ),
    );
  }

  ListView MemoryListBody() {
    return ListView.builder(
        itemCount: memoryCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.blue[100],
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black38,
                child: Icon(Icons.menu_book_sharp, color: Colors.white),
              ),
              title: Text(
                this.memories![position].name,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[700],
                    fontStyle: FontStyle.italic,
                    fontSize: 20),
              ),
              subtitle: Text(
                this.memories![position].mostRecentText,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blueAccent[200],
                    fontStyle: FontStyle.italic,
                    fontSize: 13),
              ),
              onTap: () {
                goToDetail(this.memories![position]);
              },
            ),
          );
        });
  }

  void goToMemoryAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MemoryAdd()));
    if (result != null) {
      if (result) {
        getMemory();
      }
    }
  }

  void getMemory() {
    var memoriesFuture = dbHelper.getMemories();

    memoriesFuture.then((data) {
      setState(() {
        this.memories = data;
        memoryCount = data.length;
      });
    });
  }

  void goToDetail(MemoryItemModel memory) async {
    bool result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MemoryDetail(
                  memory: memory,
                )));
    if (result != null) {
      if (result) {
        getMemory();
      }
    }
  }
}
