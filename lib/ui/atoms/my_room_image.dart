import 'package:chat_flutter/ui/pages/room/room_controller.dart';
import 'package:chat_flutter/ui/pages/room/room_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRoomImage extends StatelessWidget {
  const MyRoomImage({Key key, this.size, this.roomController})
      : super(key: key);
  final double size;
  final RoomController roomController;

  @override
  Widget build(BuildContext context) {
    final RoomEditController roomEditController =
        Provider.of<RoomEditController>(context);
    if (roomEditController.selectedImageFile != null) {
      return SizedBox(
        width: size,
        height: size,
        child: CircleAvatar(
          backgroundImage: FileImage(roomEditController.selectedImageFile),
        ),
      );
    } else if (roomController.room.imgUrl != '' &&
        roomController.room.imgUrl != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(roomController.room.imgUrl),
          ),
        ),
      );
    } else {
      return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/avatar.JPG'),
          ),
        ),
      );
    }
  }
}
