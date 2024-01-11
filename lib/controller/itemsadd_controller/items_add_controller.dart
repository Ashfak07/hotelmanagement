import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemAddController with ChangeNotifier {
  Future additemstoinventory(
      String itemname, String qty, String price, String image) async {
    await FirebaseFirestore.instance.collection('inventory').add(
        {"itemName": itemname, "qty": qty, "price": price, "image": image});
    notifyListeners();
  }
}
