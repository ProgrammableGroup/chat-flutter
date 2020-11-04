import 'package:flutter/material.dart';

class ProfilePageAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Color(0xff707070),
      ),
      title: const Text(
        'Profile',
        style: TextStyle(
          color: Color(0xff707070),
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Container(),
    );
  }
}
