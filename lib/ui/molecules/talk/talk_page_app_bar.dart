import 'package:chat_flutter/ui/pages/talk/talk_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TalkPageAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      title: const Text(
        'Talk',
        style: TextStyle(
          color: Color(0xff707070),
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Container(),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.refresh,
          ),
          onPressed: () async {
            await Provider.of<TalkController>(context, listen: false)
                .getMyRoomList();
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.add_comment,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/selectMemberPage');
          },
        ),
      ],
      iconTheme: const IconThemeData(
        color: Color(0xff707070),
      ),
    );
  }
}
