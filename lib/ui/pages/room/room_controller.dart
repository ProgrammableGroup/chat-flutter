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
  final ScrollController scrollController = ScrollController();
  final FirebaseRoomService firebaseRoomService = FirebaseRoomService();
  final MessageService messageService;
  final Authenticator authenticator;
  String userId;
  bool isReading = true;

  Future<void> sendMessage(String message, String roomId) async {
    await messageService.sendMessage(message, roomId, userId);
    notifyListeners();
  }

  Stream<List<Message>> messageList(String roomId) {
    return messageService.getMessage(roomId, userId);
  }

  Stream<List<DateTime>> lastReadTimeList(String roomId) {
    return FirebaseRoomService().getLastReadTimeList(roomId);
  }

  StreamSubscription<List<Message>> listenStream() {
    return messageList(room.id).listen((event) async {
      if (isReading) {
        //読んだ時間更新
        await FirebaseRoomService().setMyLastReadTime(room.id, userId);
      }
    });
  }

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

  Future<void> scrollPage() async {
    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      //スクロール時間
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    isReading = false;
    notifyListeners();
    super.dispose();
  }
}
