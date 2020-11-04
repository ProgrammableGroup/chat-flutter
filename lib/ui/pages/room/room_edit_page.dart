import 'package:chat_flutter/model/room.dart';
import 'package:chat_flutter/ui/atoms/my_room_image.dart';
import 'package:chat_flutter/ui/pages/room/room_controller.dart';
import 'package:chat_flutter/ui/pages/room/room_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/config/app_text_size.dart';
import 'package:provider/provider.dart';

class RoomEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RoomController roomController =
        ModalRoute.of(context).settings.arguments as RoomController;
    final room = roomController.room;
    return ChangeNotifierProvider<RoomEditController>(
      create: (_) => RoomEditController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Room',
            style: TextStyle(
              color: Color(0xff707070),
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Color(0xff707070),
          ),
        ),
        backgroundColor: Colors.white,
        body: (room == null)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _RoomEditPage(
                roomController: roomController,
              ),
      ),
    );
  }
}

class _RoomEditPage extends StatelessWidget {
  final RoomController roomController;

  const _RoomEditPage({Key key, this.roomController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Room room = roomController.room;
    final RoomEditController roomEditController =
        Provider.of<RoomEditController>(context);
    final TextEditingController nameController = TextEditingController(
      text: room.name,
    );
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              final imagePicker = ImagePicker();
              final selectImage = await imagePicker.getImage(
                source: ImageSource.gallery,
              );
              if (selectImage != null) {
                roomEditController.notifySelectImage(
                  selectImage.path,
                );
              }
            },
            child: MyRoomImage(
              size: 150,
              roomController: roomController,
            ),
          ),
          const SizedBox(
            height: AppSpace.small,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.midium,
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 1,
              controller: nameController,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppTextSize.xlarge,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: AppSpace.large,
          ),
          Center(
            child: SizedBox(
              width: 150,
              child: RaisedButton.icon(
                icon: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
                label: const Text('更新する'),
                onPressed: () async {
                  await roomController.changeRoomInfo(nameController.text,
                      roomEditController.selectedImageFile);
                  Navigator.of(context).pop();
                },
                color: Colors.redAccent,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
