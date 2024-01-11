import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hotelmanagement/Chefapp/login/cheflogin.dart';
import 'package:hotelmanagement/screens/login_screen/login_screen.dart';
import 'package:hotelmanagement/services/firebase_auth_services/firebase_auth_services.dart';
import 'package:hotelmanagement/utils/common/colorconstants/color_constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    super.key,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isSecurePassword = true;
  final FirebaseAuthServices auth = FirebaseAuthServices();
  // RegistrationController registrationController = RegistrationController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  FocusNode fieldone = FocusNode();
  FocusNode fieldtwo = FocusNode();
  FocusNode fieldthree = FocusNode();
  FocusNode fieldfour = FocusNode();
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    // var mediaheight = MediaQuery.sizeOf(context).height;
    var mediawidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: ColorConstants.bannerColor),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      focusNode: fieldone,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(fieldtwo);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ('require');
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: usernameController,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      focusNode: fieldtwo,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(fieldthree);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'username',
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ('require');
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: mobileController,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      focusNode: fieldthree,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(fieldthree);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'mobile',
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ('require');
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passwordController,
                      focusNode: fieldfour,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'password',
                          prefixIcon: Icon(Icons.key),
                          suffixIcon: togglePassword()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ('require');
                        } else {
                          return null;
                        }
                      },
                      obscureText: _isSecurePassword,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                        child: Text(
                          'Already have account',
                          style: TextStyle(fontSize: mediawidth * .03),
                        ),
                      )),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 5),
                child: InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      signUp();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorConstants.bannerColor,
                        borderRadius: BorderRadius.circular(15)),
                    height: 50,
                    child: Center(
                      child: Text(
                        "Signup",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            _isSecurePassword = !_isSecurePassword;
          });
        },
        icon: _isSecurePassword
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off));
  }

  void signUp() async {
    User? user = await auth.signupWithEmailandPassword(
        emailController.text, passwordController.text);
    auth.addchef(
        usernameController.text, mobileController.text, emailController.text);
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChefLogin()));
    }
  }
}
