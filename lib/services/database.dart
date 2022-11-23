import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/pengguna_data.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({required this.uid});

  // Firestore changed to FirebaseFirestore
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

  // the document changed to doc and setData changed to set
  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      "sugars": sugars,
      "name": name,
      "strength": strength,
    });
  }

  // brew list from snapshot
  Iterable<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc["name"] ?? "",
          sugars: doc["sugars"] ?? "0",
          strength: doc["strength"] ?? 0);
    }).toList();
  }

  // userData from snapshot
  PenggunaData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return PenggunaData(
        uid: uid!,
        name: snapshot["name"],
        sugars: snapshot["sugars"],
        strength: snapshot["strength"]);
  }

  // get brews stream
  Stream<Iterable<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<PenggunaData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
