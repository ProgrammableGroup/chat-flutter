import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter/di.dart';
import 'package:chat_flutter/ui/pages/main.dart';
import 'package:chat_flutter/ui/pages/profile_edit.dart';
import 'package:chat_flutter/ui/pages/profile.dart';
import 'package:chat_flutter/ui/pages/sign_in.dart';
import 'package:chat_flutter/ui/pages/sign_up.dart';
import 'package:chat_flutter/ui/pages/add_friend.dart';
import 'package:chat_flutter/ui/pages/create_group.dart';
import 'package:chat_flutter/ui/pages/room.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/mainPage',
      routes: {
        '/mainPage': (context) => MainPage(),
        '/signUpPage': (context) => SignUpPage(),
        '/signInPage': (context) => SignInPage(),
        '/roomPage': (context) => RoomPage(),
        '/profilePage': (context) => ProfilePage(),
        '/profileEditPage': (context) => ProfileEditPage(),
        '/addFriendPage': (context) => AddFriendPage(),
        '/createGroupPage': (context) => CreateGroupPage(),
      },
    );
  }
}
