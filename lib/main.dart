import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/const/colors.dart';
import 'package:quiz_app/const/images.dart';
import 'package:quiz_app/const/text_style.dart';
import 'package:quiz_app/quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Quiz());
  }
}

class Quiz extends StatelessWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              // begin: Alignment.topCenter,
              // end: Alignment.bottomCenter,
              colors: [blue, darkBlue],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: lightgrey, width: 3),
                    borderRadius: BorderRadius.circular(30)),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.xmark,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              Image.asset(
                quiz1,
              ),
              const SizedBox(
                height: 20,
              ),
              normalText(text: "Welcome to our", size: 18, color: Colors.white),
              headingText(text: "Quiz", size: 32, color: lightgrey),
              const SizedBox(
                height: 20,
              ),
              normalText(
                  text: "Do You Feel Confident? You will face Some Question",
                  size: 16,
                  color: Colors.white),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => quizscreen(),
                      ),
                    );
                  }),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    width: size.width - 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: headingText(
                      color: blue,
                      size: 18,
                      text: "Continue",
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
