import 'dart:async';
import 'dart:io';

import 'package:chat_flutter/model/message.dart';
import 'package:chat_flutter/model/room.dart';
import 'package:chat_flutter/model/storage_type.dart';
import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/services/firebase_room_service.dart';
import 'package:chat_flutter/services/firebase_storage_service.dart';
import 'package:chat_flutter/services/message_service.dart';
import 'package:flutter/material.dart';

class RoomController extends ChangeNotifier {
  RoomController({this.messageService, this.authenticator, this.room}) {
    Future(() async {
      userId = await authenticator.getUid();
      notifyListeners();
    });
  }
  final Room room;
  final FirebaseRoomService firebaseRoomService = FirebaseRoomService();
  final MessageService messageService;
  final Authenticator authenticator;
  String userId;

  Future<void> sendMessage(String message, String roomId) async {
    await messageService.sendMessage(message, roomId, userId);
    notifyListeners();
  }

  Stream<List<Message>> messageList(String roomId) {
    return messageService.getMessage(roomId, userId);
  }

  Stream<List<DateTime>> lastReadTimeList(String roomId){
    return FirebaseRoomService().getLastReadTimeList(roomId);
  }

  StreamSubscription<List<Message>> listenStream() {
  return messageList(room.id).listen((event) {
      //読んだ時間更新
      FirebaseRoomService().updateLastReadTime(room.id, userId);
    });}
  Future<void> changeRoomInfo(String name, File selectedImageFile) async {
    room.name = name;
    if (selectedImageFile != null) {
      room.imgUrl = await FirebaseStorageService().uploadImage(
        selectedImageFile,
        room.id,
        StorageType.room,
      );
    }
    await firebaseRoomService.updateRoomData(room);
    notifyListeners();
  }
  @override
  void dispose(){
    listenStream().cancel();
    super.dispose();
  }
}
