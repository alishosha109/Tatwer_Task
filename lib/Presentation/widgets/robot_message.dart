import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget robotMessage(message, {choices = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
              // ignore: prefer_const_constructors
              image: DecorationImage(
                image: const AssetImage('assets/images/robot_icon.png'),
                fit: BoxFit.none,
              ),
              color: Colors.grey.withOpacity(0.2),
              shape: BoxShape.circle),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  message,
                  style: TextStyle(
                      fontFamily: 'poppin', fontWeight: FontWeight.bold),
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: 6.h,
            width: 70.w,
          ),
        )
      ],
    ),
  );
}
