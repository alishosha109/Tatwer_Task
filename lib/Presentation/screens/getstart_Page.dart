// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tatwer_task/constants/strings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GetStartPage extends StatelessWidget {
  const GetStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 9.h,
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w, top: 2.h),
                child: Image(image: AssetImage('assets/images/border.png')),
              ),
              Column(
                children: [
                  Container(
                      width: 248,
                      height: 134,
                      // ignore: prefer_const_constructors
                      child: RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontSize: 19,
                                fontFamily: 'poppin',
                                color: Colors.black),
                            children: [
                              TextSpan(text: "Hi, My name is "),
                              TextSpan(
                                  text: "Oranobot    ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: "I will always be there to "),
                              TextSpan(text: "help and assist you."),
                            ]),
                      )),
                  Container(
                    width: 248,
                    height: 134,
                    child: const Text(
                      "Say Start To go to Next.",
                      style: TextStyle(fontSize: 19, fontFamily: 'poppin'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Image(image: AssetImage('assets/images/robot.png')),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
            width: 147,
            height: 53,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Color(0xFF16919b)),
              child: const Text(
                'Next',
                style: TextStyle(fontFamily: 'poppin'),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(getstart_1Screen);
              },
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.language),
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  "English",
                  style: TextStyle(
                      fontSize: 12, color: Colors.black, fontFamily: 'poppin'),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
