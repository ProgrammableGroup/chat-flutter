import 'dart:io';

import 'package:chat_flutter/model/room.dart';
import 'package:chat_flutter/model/storage_type.dart';
import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/services/firebase_room_service.dart';
import 'package:chat_flutter/services/firebase_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_flutter/model/user.dart';
import 'package:image_picker/image_picker.dart';

class CreateRoomController with ChangeNotifier {
  CreateRoomController({this.authenticator});

  File selectedImageFile;
  Room room = Room();
  final Authenticator authenticator;
  final FirebaseRoomService _firebaseRoomService = FirebaseRoomService();

  Future<void> createRoom(List<User> members, String roomName) async {
    final List<String> memberIdList = members.map((member) {
      return member.id;
    }).toList();

    // 自分のIDを追加
    final String myId = await authenticator.getUid();
    memberIdList.add(myId);

    room = Room(
      id: '',
      name: roomName,
      members: memberIdList,
      // 初めはブランクで入れておく
      imgUrl: '',
      lastMessage: <String, dynamic>{
        'text': '',
        'createdAt': FieldValue.serverTimestamp(),
      },
    );

    room.id = await _firebaseRoomService.setRoomData(room);

    if (selectedImageFile != null) {
      //roomIdで画像URLを作成する
      room.imgUrl = await FirebaseStorageService()
          .uploadImage(selectedImageFile, room.id, StorageType.room);
      await FirebaseRoomService().updateRoomData(room);
    }

    // メンバー全員のroom_settingを作成(Cloud Functionsで実装する？)
    memberIdList.forEach((userId) async {
      await _firebaseRoomService.setMyRoomSetting(userId, room.id);
    });
  }

  Future<void> selectProfileImage() async {
    final imagePicker = ImagePicker();
    final selectedImage =
        await imagePicker.getImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      selectedImageFile = File(selectedImage.path);
      notifyListeners();
    }
  }
}
