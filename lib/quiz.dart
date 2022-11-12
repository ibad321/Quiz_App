import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/api.dart';
import 'package:quiz_app/const/colors.dart';
import 'package:quiz_app/const/images.dart';
import 'package:quiz_app/const/text_style.dart';
import 'package:quiz_app/point_screen.dart';

class quizscreen extends StatefulWidget {
  const quizscreen({Key? key}) : super(key: key);

  @override
  State<quizscreen> createState() => _quizscreenState();
}

class _quizscreenState extends State<quizscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quiz = getApi();
    starttimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    starttimer();
  }

  int second = 60;
  Timer? timer;
  int points = 0;
  late Future? quiz;
  var is_loaded = false;
  var optionlist = [];

  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  var currentquestionindex = 0;
  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  starttimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (second > 0) {
          second--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  gotoNextQuestion() {
    is_loaded = false;
    currentquestionindex++;
    resetColors();
    timer!.cancel();
    second = 60;
    starttimer();
  }

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
          child: FutureBuilder(
            future: quiz,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data["results"];

                if (is_loaded == false) {
                  optionlist = data[currentquestionindex]["incorrect_answers"];
                  optionlist.add(data[currentquestionindex]["correct_answer"]);
                  optionlist.shuffle();
                  is_loaded = true;
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: lightgrey, width: 3),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              CupertinoIcons.xmark,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            normalText(
                                color: Colors.white, size: 20, text: "$second"),
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                value: second / 60,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton.icon(
                            onPressed: null,
                            icon: const Icon(
                              CupertinoIcons.heart,
                              size: 18,
                              color: Colors.white,
                            ),
                            label: normalText(
                                text: "Like", size: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      ideas,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: normalText(
                          text:
                              "Question${currentquestionindex + 1} of ${data.length}",
                          size: 18,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    normalText(
                        text: data[currentquestionindex]["question"],
                        size: 14,
                        color: Colors.white),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: optionlist.length,
                        itemBuilder: (context, index) {
                          var answer =
                              data[currentquestionindex]["correct_answer"];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (answer.toString() ==
                                    optionlist[index].toString()) {
                                  optionsColor[index] = Colors.green;
                                  points = points + 10;
                                  print(points);
                                  ;
                                } else {
                                  optionsColor[index] = Colors.red;
                                }

                                if (currentquestionindex < data.length - 1) {
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    gotoNextQuestion();
                                  });
                                } else {
                                  timer!.cancel();
                                  //here you can do whatever you want with the results
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              point_screen(points))));
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(16),
                              width: size.width - 100,
                              decoration: BoxDecoration(
                                color: optionsColor[index],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: headingText(
                                color: blue,
                                size: 10,
                                text: optionlist[index].toString(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
