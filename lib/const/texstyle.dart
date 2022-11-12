import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget normaltext({String? text, Color? color, double? size}) {
  return Text(
    "Welcome to our",
    style: TextStyle(
      color: color,
      fontFamily: "quick_semi",
      fontSize: size,
    ),
  );
}
Widget headingtext({String? text, Color? color, double? size}) {
  return Text(
    "Welcome to our",
    style: TextStyle(
      color: color,
      fontFamily: "quick_bold",
      fontSize: size,
    ),
  );
}
