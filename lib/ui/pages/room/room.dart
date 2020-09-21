import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/model/message.dart';
import 'package:chat_flutter/model/room.dart';
import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/services/message_service.dart';
import 'package:chat_flutter/ui/molecules/message/list.dart';
import 'package:chat_flutter/ui/molecules/room/input_message_text_field.dart';
import 'package:chat_flutter/ui/pages/room/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatelessWidget {
  const RoomPage._({Key key}) : super(key: key);

  static Widget wrapped(BuildContext context, Authenticator authenticator) {
    return ChangeNotifierProvider<RoomController>(
      create: (_) => RoomController(
        messageService: Provider.of<MessageService>(context, listen: false),
        authenticator: authenticator,
      ),
      child: const RoomPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Room room = ModalRoute.of(context).settings.arguments as Room;
    final roomController = Provider.of<RoomController>(context);
    final TextEditingController textController = TextEditingController();
    if (roomController.userId == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
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
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              StreamProvider<List<Message>>(
                create: (_) => roomController.messageList(room.id),
                initialData: const [],
                child: MessageList(),
              ),
              const SizedBox(
                height: AppSpace.xBig,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(
                      width: AppSpace.small,
                    ),
                    InputMessageTextField(
                      roomTextController: textController,
                    ),
                    const SizedBox(
                      width: AppSpace.xsmall,
                    ),
                    IconButton(
                      onPressed: () async {
                        await roomController.sendMessage(
                          textController.text,
                          room.id,
                        );
                        textController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSpace.midium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
