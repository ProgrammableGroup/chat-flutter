import 'package:chat_flutter/model/room.dart';
import 'package:chat_flutter/ui/molecules/talk/talk_page_list_tile.dart';
import 'package:chat_flutter/ui/pages/talk/talk_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TalkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Room> roomList = Provider.of<TalkController>(context).roomList;
    if (roomList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: roomList.length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        return TalkPageListTile(roomList[index]);
      },
    );
  }
}
