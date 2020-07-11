import 'package:chat_flutter/di.dart';
import 'package:chat_flutter/ui/pages/main.dart';
import 'package:chat_flutter/ui/pages/profile_edit.dart';
import 'package:chat_flutter/ui/pages/profile.dart';
import 'package:chat_flutter/ui/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        '/profilePage': (context) => ProfilePage(),
        '/profileEditPage': (context) => ProfileEditPage(),
      },
    );
  }
}
