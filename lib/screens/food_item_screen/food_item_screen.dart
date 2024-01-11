import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/controller/food_add_controller/food_add_controller.dart';
import 'package:hotelmanagement/controller/itemsadd_controller/items_add_controller.dart';
import 'package:hotelmanagement/screens/food_item_screen/widgets/button.dart';
import 'package:hotelmanagement/screens/food_item_screen/widgets/popup.dart';
import 'package:hotelmanagement/utils/common/snackbar/snackbar_screen.dart';
import 'package:hotelmanagement/utils/common/textstyle/text_style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

class FoodItemsScreen extends StatefulWidget {
  const FoodItemsScreen({super.key});

  @override
  State<FoodItemsScreen> createState() => _FoodItemsScreenState();
}

class _FoodItemsScreenState extends State<FoodItemsScreen> {
  String imageUrl = '';
  File? _image;
  final ImagePicker imgpicker = ImagePicker();
  Uint8List? imagearray;
  CollectionReference items =
      FirebaseFirestore.instance.collection('Fooditems');
  TextEditingController itemnamecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var Mediaheight = MediaQuery.sizeOf(context).height;
    var Mediawidth = MediaQuery.sizeOf(context).width;
    fooditems itemsadd = Provider.of(context, listen: false);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: Mediaheight * 200,
                      child: Column(
                        children: [
                          Form(
                            key: _formkey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Add items ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 40,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          DottedBorder(
                                              padding: EdgeInsets.all(40),
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              strokeWidth: 1,
                                              child: _image != null
                                                  ? Image.file(
                                                      _image!,
                                                      width: 50,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Icon(Icons.camera)),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              selectedimage();
                                            },
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  "Add image",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: itemnamecontroller,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        scrollPhysics:
                                            NeverScrollableScrollPhysics(),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'item name',
                                            prefixIcon: Icon(Icons.shop)),
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
                                      // TextFormField(
                                      //   controller: quantitycontroller,
                                      //   keyboardType:
                                      //       TextInputType.emailAddress,
                                      //   scrollPhysics:
                                      //       NeverScrollableScrollPhysics(),
                                      //   decoration: InputDecoration(
                                      //       border: OutlineInputBorder(),
                                      //       hintText: 'qty',
                                      //       prefixIcon: Icon(Icons
                                      //           .production_quantity_limits)),
                                      //   validator: (value) {
                                      //     if (value == null || value.isEmpty) {
                                      //       return ('required');
                                      //     } else {
                                      //       return null;
                                      //     }
                                      //   },
                                      // ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: pricecontroller,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        scrollPhysics:
                                            NeverScrollableScrollPhysics(),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Price',
                                            prefixIcon: Icon(Icons.money)),
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
                                          if (_formkey.currentState!
                                                  .validate() &&
                                              imageUrl != null) {
                                            itemsadd.addFoodItems(
                                                itemnamecontroller.text,
                                                pricecontroller.text,
                                                imageUrl);
                                            setState(() {});
                                          } else {
                                            ShowSnackbar().showSnackbar(
                                                context: context,
                                                content: Text('fill all'));
                                          }
                                        },
                                        child: Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
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
                        ],
                      ),
                    );
                  });
            },
            child: Icon(Icons.add)),
        body: StreamBuilder(
            stream: items.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot items = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
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
                                    color: Colors.grey,
                                    offset: Offset(9.0, 7), //(x,y)
                                    blurRadius: 9.0,
                                  )
                                ]),
                            child: Column(
                              children: [
                                Container(
                                  height: 130,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            items['imageurl'],
                                          ))),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      items['itemName'],
                                      style: TextStyleConstants.heading4,
                                    ),
                                    Button(
                                      docId: items.id,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  void selectedimage() async {
    XFile? file = await imgpicker.pickImage(source: ImageSource.camera);
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    _image = File(file!.path);
    imagearray = _image!.readAsBytesSync();
    if (file == null) return;
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference imagedir = referenceroot.child('images');
    Reference imagetouplod = imagedir.child(filename);
    UploadTask uploadTask = imagetouplod.putFile(File(file.path));
    uploadTask.whenComplete(() async {
      imageUrl = await imagetouplod.getDownloadURL();
    });
    // try {

    // } on FirebaseException catch (error) {
    //   print(error);
    // }
    // print(imageUrl);
    // setState(() {});
  }
}
