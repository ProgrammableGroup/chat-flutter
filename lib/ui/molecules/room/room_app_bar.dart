import 'package:flutter/material.dart';
import 'package:chat_flutter/model/room.dart';
import 'package:provider/provider.dart';
import 'package:chat_flutter/ui/pages/room/room_controller.dart';

class RoomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final roomController = Provider.of<RoomController>(context);
    final Room room = roomController.room;
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Color(0xff707070),
      ),
      title: Text(
        room.name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color(0xff707070),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () async {
          roomController.dispose();
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () async {
            await Provider.of<RoomController>(context, listen: false)
                .scrollPage();
          },
          icon: const Icon(
            Icons.arrow_downward,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed<void>(
              context,
              '/roomEditPage',
              arguments: roomController,
            );
          },
          icon: const Icon(
            Icons.more_vert,
          ),
        ),
      ],
    );
  }
}
