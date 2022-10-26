import 'package:flutter/material.dart';
import 'package:tatwer_task/Presentation/screens/chat_Page.dart';
import 'package:tatwer_task/Presentation/screens/getstart_Page.dart';
import 'package:tatwer_task/Presentation/screens/home_page.dart';
import 'package:tatwer_task/Presentation/screens/start_Page.dart';
import 'package:tatwer_task/business_logic/cubit/chat_cubit.dart';
import 'package:tatwer_task/business_logic/cubit/experts_cubit.dart';
import 'package:tatwer_task/data/apis/chat_apis.dart';
import 'package:tatwer_task/data/apis/experts_apis.dart';
import 'package:tatwer_task/data/repos/chat_repo.dart';
import 'package:tatwer_task/data/repos/experts_repo.dart';

import 'constants/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: startScreen,
        routes: {
          startScreen: (context) => const StartPage(),
          getstartScreen: (context) => GetStartPage(),
          getstart_1Screen: (context) => BlocProvider(
                create: (context) => ChatCubit(ChatRepo(ChatApis())),
                child: ChatPage(),
              ),
          homeScreen: (context) => BlocProvider(
                create: (context) => ExpertsCubit(ExpertsRepo(ExpertsApis())),
                child: HomePage(),
              ),
          // addpostScreen: (context) => BlocProvider(
          //       create: (context) => PostsCubit(postsRepo(postsApis())),
          //       child: AddPost(),
          //     ),
          // myPostsScreen: (context) => BlocProvider(
          //       create: (context) => PostsCubit(postsRepo(postsApis())),
          //       child: MyPostsPage(),
          //     ),
          // ProfileScreen: (context) => BlocProvider(
          //       create: (context) => UsersCubit(usersRepo(usersApis())),
          //       child: ProfilePage(),
          //     ),
          // ChoicesScreen: (context) => BlocProvider(
          //       create: (context) => PostsCubit(postsRepo(postsApis())),
          //       child: ChoicesHistoryPage(),
          //     ),
        },
      );
    });
  }
}
