import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/model/user.dart';
import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/ui/molecules/create_room/room_image.dart';
import 'package:chat_flutter/ui/molecules/create_room/room_member_list.dart';
import 'package:chat_flutter/ui/pages/create_room/create_room_controller.dart';
import 'package:flutter/material.dart';

import 'package:chat_flutter/config/app_text_size.dart';
import 'package:provider/provider.dart';

class CreateRoomPage extends StatelessWidget {
  const CreateRoomPage._({Key key}) : super(key: key);
  static Widget wrapped(Authenticator authenticator) {
    return ChangeNotifierProvider<CreateRoomController>(
      create: (_) => CreateRoomController(authenticator: authenticator),
      child: const CreateRoomPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<User> members =
        ModalRoute.of(context).settings.arguments as List<User>;
    final TextEditingController _textEditingController =
        TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Group',
          style: TextStyle(
            color: Color(0xff707070),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xff707070),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              //room作成
              await Provider.of<CreateRoomController>(
                context,
                listen: false,
              ).createRoom(members, _textEditingController.text);
              await Navigator.pushReplacementNamed(context, '/homePage');
            },
            icon: const Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: AppSpace.midium,
          ),
          FlatButton(
            onPressed: () async {
              await Provider.of<CreateRoomController>(
                context,
                listen: false,
              ).selectProfileImage();
            },
            child: const RoomImage(
              size: 100,
            ),
          ),
          SizedBox(
            width: 250,
            child: TextField(
              controller: _textEditingController,
              style: const TextStyle(
                fontSize: AppTextSize.xlarge,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: AppSpace.big,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: AppSpace.midium,
              ),
              child: Text(
                'members',
                style: TextStyle(
                  fontSize: AppTextSize.small,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: RoomMemberList(
              members: members,
            ),
          ),
        ],
      ),
    );
  }
}
