import 'package:flutter/material.dart';

class ProfilePageAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Color(0xff707070),
      ),
      title: Text(
        "Profile",
        style: TextStyle(
          color: Color(0xff707070),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.more_vert,
          ),
          color: Color(0xff707070),
          onPressed: () {},
        ),
      ],
    );
  }
}
