import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: const Color(0xffEEEEEE),
      title: Text(
        'Chat',
        style: TextStyle(
          color: const Color(0xff707070),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.person_add,
          ),
          color: const Color(0xff707070),
          onPressed: () {
            Navigator.pushNamed(context, '/addFriendPage');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.group_add,
          ),
          color: const Color(0xff707070),
          onPressed: () {
            Navigator.pushNamed(context, '/createGroupPage');
          },
        ),
      ],
    );
  }
}
