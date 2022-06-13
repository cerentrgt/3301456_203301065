import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_notebook/models/Status.dart';
import 'package:memory_notebook/service/StorageService.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService storageService = StorageService();
  String mediaUrl = "";

  //veri ekleme
  Future<Status> addStatus(String status, PickedFile pickedFile) async {
    var ref = _firestore.collection("Status");
    if (pickedFile == null) {
      mediaUrl = "";
    } else {
      mediaUrl = await storageService.uploadMedia(
        File(pickedFile.path),
      );
    }

    var documentRef = await ref.add({
      'status': status,
      'image': mediaUrl,
    });
    return Status(id: documentRef.id, status: status, image: mediaUrl);
  }

  //veri çekme
  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore.collection("Status").snapshots();
    return ref;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getImage(){
    var ref = _firestore.collection("Status").doc("image").snapshots();
    return ref;
  }

  //veri silme
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("Status").doc(docId).delete();
    return ref;
  }
}
