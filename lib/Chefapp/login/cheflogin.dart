import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/Chefapp/homepage/home_screen.dart';
import 'package:hotelmanagement/Chefapp/registeration/registratio.dart';
import 'package:hotelmanagement/main.dart';
import 'package:hotelmanagement/services/firebase_auth_services/firebase_auth_services.dart';
import 'package:hotelmanagement/utils/common/colorconstants/color_constants.dart';
import 'package:hotelmanagement/utils/common/snackbar/snackbar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChefLogin extends StatefulWidget {
  ChefLogin({super.key});

  @override
  State<ChefLogin> createState() => _ChefLoginState();
}

class _ChefLoginState extends State<ChefLogin> {
  @override
  int index = 0;

  bool _isSecurePassword = true;

  final FirebaseAuthServices auth = FirebaseAuthServices();

  // RegistrationController registrationController = RegistrationController();
  final _formkey = GlobalKey<FormState>();

  TextEditingController _usernamecontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.sizeOf(context).width;
    var mediaheight = MediaQuery.sizeOf(context).height;
    FocusNode fieldone = FocusNode();
    FocusNode fieldtwo = FocusNode();
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formkey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 150, vertical: 42),
                  ),
                  height: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(80),
                      ),
                      color: ColorConstants.bannerColor),
                  // child: Image.asset(
                  //   'assets/images/shopping.png',
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              Container(
                color: ColorConstants.bannerColor,
                child: Container(
                  height: 526,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          bottomRight: Radius.circular(60)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Chef',
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.bannerColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            TextFormField(
                              controller: _usernamecontroller,
                              keyboardType: TextInputType.emailAddress,
                              scrollPhysics: NeverScrollableScrollPhysics(),
                              focusNode: fieldone,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(fieldtwo);
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'username or email',
                                  prefixIcon: Icon(Icons.person)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ('required');
                                  // } else if (value.isNotEmpty &&
                                  //     mydb.keys.contains(value)) {
                                  //   return ("UserName is not registered");
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _passwordcontroller,
                              scrollPhysics: NeverScrollableScrollPhysics(),
                              focusNode: fieldtwo,
                              // onFieldSubmitted: (value) {
                              //   FocusScope.of(context).requestFocus(fieldtwo);
                              // },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'password',
                                  prefixIcon: Icon(Icons.key),
                                  suffixIcon: togglePassword()),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ('required');
                                } else {
                                  return (null);
                                }
                              },
                              obscureText: _isSecurePassword,
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //     bottom: 450,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 180),
                      //       child: Container(child: Text('OR')),
                      //     )),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrationScreen()));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 1),
                                child: Text(
                                  'Don\'t have account?',
                                  style: TextStyle(fontSize: mediaWidth * .03),
                                ),
                              )),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 5),
                        child: InkWell(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              sign();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstants.bannerColor,
                                borderRadius: BorderRadius.circular(15)),
                            height: 50,
                            child: Center(
                              child: Text(
                                "Sign in",
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
              // Spacer(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                      ),
                      color: ColorConstants.bannerColor),
                  // child: Image.asset(
                  //   'assets/images/shopping.png',
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
            ],
          ),
        ));
  }

  void sign() async {
    User? user = await auth.signInWithEmailandPassword(
        _usernamecontroller.text, _passwordcontroller.text);
    final sharedpref = await SharedPreferences.getInstance();
    await sharedpref.setBool(saveKey, true);
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => chefHomeScreen()));
    } else {
      final _errorMessage = 'password and username does not match';
      ShowSnackbar().showSnackbar(context: context, content: _errorMessage);
    }
  }

  // void checkLogin(BuildContext context) async {
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
}
