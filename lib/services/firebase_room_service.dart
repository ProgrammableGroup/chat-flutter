import 'package:chat_flutter/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRoomService {
  final Firestore _db = Firestore.instance;

  Future<String> setRoomData(Room room) async {
    final roomData = {
      'name': room.name,
      'members': room.members,
      'imgUrl': room.imgUrl,
      'lastMessage': room.lastMessage,
    };
    final DocumentReference docRef =
        await _db.collection('message/v1/rooms').add(roomData);
    return docRef.documentID;
  }

  Future<void> setRoomSetting(String userId, String roomId) async {
    final settingData = {
      'allowNotification': false,
    };

    await _db
        .collection('message/v1/users/$userId/room_setting')
        .document(roomId)
        .setData(settingData);
  }
}
