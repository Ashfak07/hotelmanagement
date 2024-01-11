import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/controller/food_add_controller/food_add_controller.dart';
import 'package:hotelmanagement/controller/itemsadd_controller/items_add_controller.dart';
import 'package:hotelmanagement/screens/bottomnavigation/bottom_navigation.dart';
import 'package:hotelmanagement/screens/chooselogintype/chooselogintype.dart';
import 'package:hotelmanagement/screens/home_screen/home_screen.dart';
import 'package:hotelmanagement/screens/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

const saveKey = 'userlogedin';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDFInuKeMd--0bvEWrnZZmzHe1PKBEEWx8',
          appId: "1:847888112569:android:7dfbc944c79f50d9573468",
          messagingSenderId: '',
          projectId: "hotelmanagement-2365c",
          storageBucket: "hotelmanagement-2365c.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ItemAddController()),
        ChangeNotifierProvider(create: (context) => fooditems())
      ],
      child: MaterialApp(
        home: ChooseLoginType(),
      ),
    );
  }
}
