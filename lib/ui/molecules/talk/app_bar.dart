import 'package:flutter/material.dart';

class TalkPageAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      title: Text(
        'Talk',
        style: TextStyle(
          color: const Color(0xff707070),
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Container(),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_comment,
          ),
          color: const Color(0xff707070),
          onPressed: () {
            Navigator.pushNamed(context, '/selectMemberPage');
          },
        ),
      ],
    );
  }
}
