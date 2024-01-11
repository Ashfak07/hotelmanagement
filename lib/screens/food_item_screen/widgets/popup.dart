import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/controller/food_add_controller/food_add_controller.dart';
import 'package:hotelmanagement/utils/common/snackbar/snackbar_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Popup extends StatefulWidget {
  Popup({super.key, required this.docId});
  String docId;
  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
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
    fooditems itemsadd = Provider.of(context, listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 500,
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
                                          if (imageUrl != null) {
                                            itemsadd.updatedata(
                                                itemnamecontroller.text,
                                                pricecontroller.text,
                                                imageUrl,
                                                widget.docId);
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
            child: Container(
              color: Color.fromARGB(255, 239, 234, 234),
              height: 50,
              width: double.infinity,
              child: Icon(Icons.edit),
            ),
          ),
          InkWell(
            onTap: () {
              itemsadd.deletedata(widget.docId);
            },
            child: Container(
              width: double.infinity,
              height: 50,
              color: Colors.grey,
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
    );
  }

  bottomSheet(BuildContext context) {
    fooditems itemsadd = Provider.of(context, listen: false);
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
  }
}
