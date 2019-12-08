import 'package:cloud_firestore/cloud_firestore.dart';

class DataHandler {

  final databaseReference = Firestore.instance;

  getData() {
    databaseReference
        .collection("reviews")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }
  // Update methods
}