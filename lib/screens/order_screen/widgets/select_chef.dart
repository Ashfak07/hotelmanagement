import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectChef extends StatefulWidget {
  const SelectChef({super.key});

  @override
  State<SelectChef> createState() => _SelectChefState();
}

class _SelectChefState extends State<SelectChef> {
  bool lights = false;
  CollectionReference chefs = FirebaseFirestore.instance.collection('chefs');
  @override
  Widget build(BuildContext context) {
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
                                  if (value == true) {}
                                  setState(() {
                                    lights = value;
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
