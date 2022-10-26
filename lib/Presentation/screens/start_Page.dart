import 'package:flutter/material.dart';
import 'package:tatwer_task/constants/strings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover)),
            // child: Container(height: 80, width: 80, color: Colors.amber),
          ),
          Center(
            child: Image.asset('assets/images/logo.png'),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  SizedBox(
                    width: 363,
                    height: 53,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle:
                              TextStyle(fontSize: 18, fontFamily: 'poppin'),
                          backgroundColor: Color(0xFF16919b)),
                      child: const Text('Get Started'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(getstartScreen);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 12, fontFamily: 'poppin'),
                      ),
                      Text(
                        "SignUp",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff16919b),
                            fontFamily: 'poppin'),
                      ),
                    ],
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
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'poppin'),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
