import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_notebook/Screens/DreamPage/DreamScreens/DreamAdd.dart';
import 'package:memory_notebook/service/StatusService.dart';


class DreamList extends StatefulWidget {
  const DreamList({Key? key}) : super(key: key);

  @override
  State<DreamList> createState() => _DreamListState();
}

class _DreamListState extends State<DreamList> {
  StatusService statusService = StatusService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HAYALLERİM"),
        backgroundColor: Colors.indigo[300],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[300],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DreamAdd(),
            ),
          );
        },
        child: const Icon(
          Icons.add_to_photos_sharp,
        ),
      ),
      body: _body(),
    );
  }

  StreamBuilder _body() {
    return StreamBuilder<QuerySnapshot>(
        stream: statusService.getStatus(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const CircularProgressIndicator(

                  color: Colors.indigo,

                )

              : snapshot.data == null
                  ? const CircularProgressIndicator(
            color: Colors.indigo,
          )
                  : mainbody(snapshot);
        });
  }

  ListView mainbody(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data?.docs.length ?? 0,
        itemBuilder: (context, index) {
          DocumentSnapshot mypost = snapshot.data!.docs[index];
          Future _showDialog() {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Silmek ister misiniz?",style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                  ),),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          statusService.removeStatus(mypost.id);
                          Navigator.pop(context);
                        },
                        child: const Text("Sil",style:  TextStyle(
                            color: Colors.red,
                            fontSize: 15
                        ),),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Vazgeç",style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15
                        )),
                      ),

                    ],
                  ),
                );
              },
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                _showDialog();
              },
              child: ListTile(
                leading: Image.network(
                  mypost['image'],

                ),
                trailing: Icon(
                  Icons.wb_sunny_outlined,
                  color: Colors.yellow[700],
                ),
                title:  Text(
                  mypost['status'],
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[700],
                      fontStyle: FontStyle.italic,
                      fontSize: 25),
                ),
              ),
            ),
          );
        });
  }
}
