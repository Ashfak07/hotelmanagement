import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final User? user = FirebaseAuth.instance.currentUser;

class FirebaseAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print('error');
    }
  }

  Future<User?> signupWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print('error');
    }
  }

  Future addchef(
    String username,
    String mobile,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection('chefs').add({
      "userName": username,
      "mobile": mobile,
      "email": email,
      "uid": user!.uid,
    });
  }
}
