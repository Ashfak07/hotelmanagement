import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderAssigning with ChangeNotifier {
  bool isaccepted = false;
  Future AssignOrder(
    String name,
    String foodname,
    String chefid,
  ) async {
    await FirebaseFirestore.instance.collection('assignedOrder').add({
      "username": name,
      "foodname": foodname,
      "chefid": chefid,
      "status": isaccepted
    });
    notifyListeners();
  }

  Future updateStatus(String docId) async {
    await FirebaseFirestore.instance
        .collection('assignedOrder')
        .doc(docId)
        .update({'status': isaccepted});
  }
}
