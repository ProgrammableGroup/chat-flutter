import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/ui/molecules/profile/profile_page_app_bar.dart';
import 'package:chat_flutter/ui/molecules/talk/talk_page_app_bar.dart';
import 'package:chat_flutter/ui/pages/home/home_controller.dart';
import 'package:chat_flutter/ui/pages/profile/profile_page.dart';
import 'package:chat_flutter/ui/pages/talk/talk_page.dart';
import 'package:chat_flutter/ui/pages/talk/talk_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage._({Key key}) : super(key: key);

  static Widget wrapped(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(
          create: (_) => HomeController(
            Provider.of<Authenticator>(
              context,
              listen: false,
            ),
          ),
        ),
        ChangeNotifierProvider<TalkController>(
          create: (_) => TalkController(
            Provider.of<Authenticator>(
              context,
              listen: false,
            ),
          ),
        ),
      ],
      child: const HomePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    final List<PreferredSizeWidget> appBarList = [
      TalkPageAppBar(),
      ProfilePageAppBar(),
    ];

    final List<StatelessWidget> pages = [
      TalkPage(),
      ProfilePage(),
    ];

    return Scaffold(
      appBar: appBarList[controller.currentIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: _bottomNavigation(context),
      body: pages[controller.currentIndex],
    );
  }

  Widget _bottomNavigation(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: controller.currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.message,
          ),
          title: Text(
            'talk',
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          title: Text(
            'profile',
          ),
        ),
      ],
      onTap: controller.changePage,
    );
  }
}
