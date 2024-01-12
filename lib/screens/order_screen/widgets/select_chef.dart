import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/controller/orderasigning_controller/order_assigning.dart';
import 'package:provider/provider.dart';

class SelectChef extends StatefulWidget {
  SelectChef({super.key, required this.username, required this.fooditem});
  String username;
  String fooditem;

  @override
  State<SelectChef> createState() => _SelectChefState();
}

class _SelectChefState extends State<SelectChef> {
  bool lights = false;
  CollectionReference chefs = FirebaseFirestore.instance.collection('chefs');
  @override
  Widget build(BuildContext context) {
    OrderAssigning assignorder = Provider.of(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('select chef'),
        ),
        body: StreamBuilder(
            stream: chefs.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot chefs = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text(chefs['userName']),
                            trailing: CupertinoSwitch(
                                value: lights,
                                onChanged: (bool value) {
                                  setState(() {
                                    lights = value;
                                    if (value == true) {
                                      assignorder.AssignOrder(widget.username,
                                          widget.fooditem, chefs['uid']);
                                    }
                                  });
                                }),
                          ),
                        ),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
