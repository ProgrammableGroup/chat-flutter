import 'package:chat_flutter/model/message.dart';
import 'package:chat_flutter/ui/molecules/message/message_list_item.dart';
import 'package:chat_flutter/ui/pages/room/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Message> messageList = Provider.of<List<Message>>(context);
    final ScrollController scrollController =
        Provider.of<RoomController>(context).scrollController;
    if (messageList == null) {
      return Container();
    } else if (messageList.isEmpty) {
      return Container();
    } else {
      return Expanded(
        child: ListView.builder(
          controller: scrollController,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: messageList.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            return MessageListItem(messageList[index]);
          },
        ),
      );
    }
  }
}
