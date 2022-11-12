import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quiz_app/const/text_style.dart';

import 'const/colors.dart';

class point_screen extends StatefulWidget {
  int points;
  point_screen(this.points);

  @override
  State<point_screen> createState() => _point_screenState();
}

class _point_screenState extends State<point_screen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int points;
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                // begin: Alignment.topCenter,
                // end: Alignment.bottomCenter,
                colors: [blue, darkBlue],
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              width: size.width - 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: headingText(
                color: blue,
                size: 18,
                text: "Your Score is ${widget.points}",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
