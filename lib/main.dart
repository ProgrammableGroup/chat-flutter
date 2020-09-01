import 'package:chat_flutter/services/messgae_service.dart';
import 'package:chat_flutter/ui/pages/create_room/select_member.dart';
import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/ui/pages/profile/profile_controller.dart';
import 'package:chat_flutter/ui/pages/sign_in/sign_in.dart';
import 'package:chat_flutter/ui/pages/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:chat_flutter/ui/pages/create_room/create_room.dart';
import 'package:chat_flutter/ui/pages/home/home.dart';
import 'package:chat_flutter/ui/pages/profile/profile_edit.dart';
import 'package:chat_flutter/ui/pages/room/room.dart';
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
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Authenticatorをコンストラクタで渡したかったので、MultiProviderではできなかった
    return ChangeNotifierProvider(
      create: (_) => ProfileController(
        Provider.of<Authenticator>(
          context,
          listen: false,
        ),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute:
            Provider.of<Authenticator>(context, listen: false).isSignIn.value
                ? '/homePage'
                : '/signUpPage',
        routes: {
          '/homePage': HomePage.wrapped,
          '/signUpPage': (context) => SignUpPage.wrapped(
              Provider.of<Authenticator>(context, listen: false)),
          '/signInPage': (context) => SignInPage.wrapped(
              Provider.of<Authenticator>(context, listen: false)),
          '/roomPage': RoomPage.wrapped,
          '/profileEditPage': (context) => ProfileEditPage(),
          '/selectMemberPage': (context) => SelectMemberPage.wrapped(),
          '/createGroupPage': (context) => CreateRoomPage.wrapped(
              Provider.of<Authenticator>(context, listen: false)),
        },
      ),
    );
  }
}
