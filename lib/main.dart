import 'package:chat_flutter/services/message_service.dart';
import 'package:chat_flutter/ui/pages/create_room/select_member_page.dart';
import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/ui/pages/profile/profile_controller.dart';
import 'package:chat_flutter/ui/pages/room/room_edit_page.dart';
import 'package:chat_flutter/ui/pages/sign_in/sign_in_page.dart';
import 'package:chat_flutter/ui/pages/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:chat_flutter/ui/pages/create_room/create_room_page.dart';
import 'package:chat_flutter/ui/pages/home/home_page.dart';
import 'package:chat_flutter/ui/pages/profile/profile_edit_page.dart';
import 'package:chat_flutter/ui/pages/room/room_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<Authenticator>(
        create: (_) => Authenticator(),
        dispose: (_, authenticator) => authenticator.dispose(),
      ),
      Provider<MessageService>(
        create: (_) => MessageService(),
      ),
    ],
    child: Wrapped(),
  ));
}

class Wrapped extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(
        Provider.of<Authenticator>(
          context,
          listen: false,
        ),
      ),
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: Provider.of<ProfileController>(context, listen: false)
            .getUserById(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
            );
          }
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: snapshot.data != '' ? '/homePage' : '/signUpPage',
            routes: {
              '/homePage': HomePage.wrapped,
              '/signUpPage': (context) => SignUpPage.wrapped(
                  Provider.of<Authenticator>(context, listen: false)),
              '/signInPage': (context) => SignInPage.wrapped(
                  Provider.of<Authenticator>(context, listen: false)),
              '/roomPage': (context) => RoomPage.wrapped(
                  context, Provider.of<Authenticator>(context, listen: false)),
              '/profileEditPage': (context) => ProfileEditPage(),
              '/roomEditPage': (context) => RoomEditPage(),
              '/selectMemberPage': (context) => SelectMemberPage.wrapped(
                  Provider.of<Authenticator>(context, listen: false)),
              '/createGroupPage': (context) => CreateRoomPage.wrapped(
                  Provider.of<Authenticator>(context, listen: false)),
            },
          );
        });
  }
}
