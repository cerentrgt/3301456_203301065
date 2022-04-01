import 'package:flutter/material.dart';
import 'package:memory_notebook/MyBackGround/DreamBackground.dart';
import 'package:memory_notebook/Screens/DreamPage/DreamScreens/DreamAdd.dart';
import 'package:memory_notebook/data/DreamDbHelper.dart';
import 'package:memory_notebook/models/DreamModel.dart';

import 'DreamDetail.dart';

class DreamList extends StatefulWidget {
  const DreamList({Key? key}) : super(key: key);

  @override
  State<DreamList> createState() => _DreamListState();
}

class _DreamListState extends State<DreamList> {
  var dbHelper = DreamDbHelper();

  List<DreamModel>? dreams;

  int dreamCount = 0;

  @override
  void initState() {
    getDream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HAYALLERİM"),
        backgroundColor: Colors.indigo[300],
      ),
      body: DreamBackground(
        child: DreamListBody(),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[300],
        onPressed: () {
          goToDreamAdd();
        },
        child: const Icon(
          Icons.add_to_photos_sharp,
        ),
      ),
    );
  }

  ListView DreamListBody() {
    return ListView.builder(
        itemCount: dreamCount,
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
                this.dreams![position].name,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[700],
                    fontStyle: FontStyle.italic,
                    fontSize: 20),
              ),
              subtitle: Text(
                this.dreams![position].descriptions,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blueAccent[200],
                    fontStyle: FontStyle.italic,
                    fontSize: 13),
              ),
              onTap: () {
                goToDetail(this.dreams![position]);
              },
            ),
          );
        });
  }

  void goToDreamAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const DreamAdd(),),);
    if (result != null) {
      if (result) {
        getDream();
      }
    }
  }

  void getDream() {
    var dreamsFuture = dbHelper.getDreams();

    dreamsFuture.then((data) {
      setState(() {
        this.dreams = data;
        dreamCount = data.length;
        print(dreamCount);
      });
    });
  }

  void goToDetail(DreamModel dream) async {
    bool result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DreamDetail(
                  dream: dream,
                )));
    if (result != null) {
      if (result) {
        getDream();
      }
    }
  }
}
