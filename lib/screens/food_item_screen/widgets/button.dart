import 'package:flutter/material.dart';
import 'package:hotelmanagement/controller/food_add_controller/food_add_controller.dart';
import 'package:hotelmanagement/screens/food_item_screen/widgets/popup.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

class Button extends StatelessWidget {
  Button({super.key, required this.docId});
  String docId;
  @override
  Widget build(BuildContext context) {
    fooditems itemsadd = Provider.of(context, listen: false);
    return GestureDetector(
      onTap: () {
        showPopover(
            context: context,
            bodyBuilder: (context) => Popup(
                  docId: docId,
                ),
            width: 250,
            height: 150);
      },
      child: Icon(Icons.more_vert),
    );
  }
}
