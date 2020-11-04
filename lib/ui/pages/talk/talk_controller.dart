import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/services/firebase_room_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_flutter/model/room.dart';

class TalkController with ChangeNotifier {
  TalkController(this.authenticator) {
    Future(() async {
      uid = await authenticator.getUid();
      await getMyRoomList();
    });
  }

  final FirebaseRoomService firebaseRoomService = FirebaseRoomService();
  Authenticator authenticator;
  String uid;
  List<Room> roomList;

  Future<void> getMyRoomList() async {
    roomList = await firebaseRoomService.getMyRoomList(uid);
    notifyListeners();
  }
}
