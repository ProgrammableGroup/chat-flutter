import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      backgroundColor: Color(0xffEEEEEE),
      title: Text(
        "Chat",
        style: TextStyle(
          color: Color(0xff707070),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
          ),
          color: Color(0xff707070),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
          ),
          color: Color(0xff707070),
          onPressed: () {},
        ),
      ],
    );
  }
}
