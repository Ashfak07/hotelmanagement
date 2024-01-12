import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screens/order_screen/widgets/select_chef.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

CollectionReference order = FirebaseFirestore.instance.collection('users');

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Table(border: TableBorder.all(), children: [
                    buildRow(
                      ['name', 'fooditem', 'assign chef'],
                      "",
                      "",
                    )
                  ]),
                  Expanded(
                      child: StreamBuilder(
                          stream: order.snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot orders =
                                        snapshot.data!.docs[index];
                                    return Table(
                                        border: TableBorder.all(),
                                        children: [
                                          buildRow(
                                            [
                                              orders['username'],
                                              orders['item'],
                                              'clickHere to select chef',
                                            ],
                                            orders['username'],
                                            orders['item'],
                                          )
                                        ]);
                                  });
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }))
                ],
              ),
            ),
          ),
        ));
  }

  TableRow buildRow(List<dynamic> cells, String name, String food) {
    return TableRow(
        children: cells
            .map((e) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SelectChef(username: name, fooditem: food)));
                },
                child: Center(child: Text(e))))
            .toList());
  }
}
