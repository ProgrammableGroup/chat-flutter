import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/services/firebase_room_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_flutter/model/room.dart';

class TalkController with ChangeNotifier {
  TalkController(this.authenticator) {
    Future(() async{
      uid = await authenticator.getUid();
      notifyListeners();
    });
  }
  final FirebaseRoomService firebaseRoomService = FirebaseRoomService();
  Authenticator authenticator;
  String uid;

  Stream<List<Future<Room>>> getStreamSnapshot() {
    return firebaseRoomService.getStreamSnapshot(uid);
  }
}
