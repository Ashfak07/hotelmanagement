import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/controller/orderasigning_controller/order_assigning.dart';
import 'package:provider/provider.dart';

class chefHomeScreen extends StatefulWidget {
  const chefHomeScreen({super.key});

  @override
  State<chefHomeScreen> createState() => _chefHomeScreenState();
}

class _chefHomeScreenState extends State<chefHomeScreen> {
  bool Accept = false;
  CollectionReference work =
      FirebaseFirestore.instance.collection('assignedOrder');
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    OrderAssigning orderstatus = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('assiggned works'),
      ),
      body: StreamBuilder(
          stream: work.where('chefid', isEqualTo: user?.uid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot work = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 200,
                        width: 170,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 134, 200, 241),
                            borderRadius: BorderRadius.circular(15),
                            // gradient: LinearGradient(
                            //     colors: [
                            //       Color.fromARGB(255, 235, 228, 228),
                            //       Color.fromARGB(255, 15, 15, 15)
                            //     ],
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 32, 32, 32),
                                offset: Offset(9.0, 7), //(x,y)
                                blurRadius: 9.0,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'coustmername: ' + work['username'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            Text(
                              'fooditem: ' + work['foodname'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 23),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //decline button
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 213, 211, 211),
                                      borderRadius: BorderRadius.circular(15),
                                      // gradient: LinearGradient(
                                      //     colors: [
                                      //       Color.fromARGB(255, 235, 228, 228),
                                      //       Color.fromARGB(255, 15, 15, 15)
                                      //     ],
                                      //     begin: Alignment.topLeft,
                                      //     end: Alignment.bottomRight),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 62, 51, 51),
                                          offset: Offset(9.0, 7), //(x,y)
                                          blurRadius: 9.0,
                                        )
                                      ]),
                                  child: Center(child: Text('Decline')),
                                ),
                                //Accept button
                                InkWell(
                                  onTap: () {
                                    Accept = true;
                                    Provider.of<OrderAssigning>(context,
                                            listen: false)
                                        .isaccepted = Accept;
                                    orderstatus.updateStatus(work.id);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 213, 211, 211),
                                        borderRadius: BorderRadius.circular(15),
                                        // gradient: LinearGradient(
                                        //     colors: [
                                        //       Color.fromARGB(255, 235, 228, 228),
                                        //       Color.fromARGB(255, 15, 15, 15)
                                        //     ],
                                        //     begin: Alignment.topLeft,
                                        //     end: Alignment.bottomRight),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(255, 62, 51, 51),
                                            offset: Offset(9.0, 7), //(x,y)
                                            blurRadius: 9.0,
                                          )
                                        ]),
                                    child: Center(child: Text('Accept')),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
