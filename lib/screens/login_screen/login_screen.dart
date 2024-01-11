import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screens/bottomnavigation/bottom_navigation.dart';
import 'package:hotelmanagement/services/firebase_auth_services/firebase_auth_services.dart';
import 'package:hotelmanagement/utils/common/snackbar/snackbar_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuthServices auth = FirebaseAuthServices();
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 60,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                scrollPhysics: NeverScrollableScrollPhysics(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Full name',
                    prefixIcon: Icon(Icons.person)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('required');
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordcontroller,
                keyboardType: TextInputType.emailAddress,
                scrollPhysics: NeverScrollableScrollPhysics(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password',
                    prefixIcon: Icon(Icons.password)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('required');
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    sigin();
                  }
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                  height: 50,
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  sigin() async {
    User? user = await auth.signInWithEmailandPassword(
        emailcontroller.text, passwordcontroller.text);
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Bottomnavigation()));
    } else {
      ShowSnackbar().showSnackbar(
          context: context, content: 'email and password does not match');
    }
  }
}
