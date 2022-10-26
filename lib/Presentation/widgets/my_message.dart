import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget myMessage(message) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Color(0xff16919B),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 6.h,
          width: 70.w,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                message,
                style: const TextStyle(
                    fontFamily: 'poppin', fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Image(image: AssetImage('assets/images/read.png')),
        )
      ],
    ),
  );
}
