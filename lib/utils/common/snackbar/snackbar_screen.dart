import 'package:flutter/material.dart';

class ShowSnackbar {
  showSnackbar({context, content}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10),
    ));
  }
}
