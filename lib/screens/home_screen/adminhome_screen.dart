import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screens/home_screen/widgets/notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference inventory =
      FirebaseFirestore.instance.collection('inventory');
  final List datas = [
    'Menue items',
    'inventory items',
    'orders',
    'users',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(fontSize: 40),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()));
              },
              child: Icon(Icons.notifications)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //first row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 151, 47, 202),
                        Color.fromARGB(255, 225, 88, 150)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(9.0, 7), //(x,y)
                          blurRadius: 9.0,
                        )
                      ]),
                  child: Column(
                    children: [Text(datas[0])],
                  ),
                ),
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 151, 47, 202),
                        Color.fromARGB(255, 225, 88, 150)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(9.0, 7), //(x,y)
                          blurRadius: 9.0,
                        )
                      ]),
                  child: Column(
                    children: [Text(datas[1])],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),

            //second row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 151, 47, 202),
                        Color.fromARGB(255, 225, 88, 150)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(9.0, 7), //(x,y)
                          blurRadius: 9.0,
                        )
                      ]),
                  child: Column(
                    children: [Text(datas[2])],
                  ),
                ),
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 151, 47, 202),
                        Color.fromARGB(255, 225, 88, 150)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(9.0, 7), //(x,y)
                          blurRadius: 9.0,
                        )
                      ]),
                  child: Column(
                    children: [Text(datas[1])],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
