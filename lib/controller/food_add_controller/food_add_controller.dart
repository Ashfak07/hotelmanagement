import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class fooditems with ChangeNotifier {
  var docRef = FirebaseFirestore.instance.collection('Fooditems').doc();
  Future addFoodItems(String itemname, String price, String image) async {
    var docRef = FirebaseFirestore.instance.collection('Fooditems').doc();
    docRef.set({
      "itemName": itemname,
      "price": price,
      "imageurl": image,
      "itemId": docRef.id
    });
    notifyListeners();
  }

  Future updatedata(
      String itemname, String price, String image, String docId) async {
    await FirebaseFirestore.instance.collection('Fooditems').doc(docId).update({
      "itemName": itemname,
      "price": price,
      "imageurl": image,
    });
  }

  Future deletedata(String docId) async {
    await FirebaseFirestore.instance
        .collection('Fooditems')
        .doc(docId)
        .delete();
  }
}
