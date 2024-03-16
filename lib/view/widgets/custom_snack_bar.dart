import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final String title;
  final Color backColor;
  final int time;

  CustomSnackBar(this.title, this.backColor, this.time, {super.key})
      : super(
          content: Text(title),
          backgroundColor: backColor,
          duration: Duration(seconds: time),
          // behavior: SnackBarBehavior.floating,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(8.0),
          // ),
        );
}
