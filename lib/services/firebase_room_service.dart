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

  Future getStreamSnapshot(String uid) async {
    final QuerySnapshot querySnapshot = await _db
        .collection('message/v1/users/$uid/room_setting')
        .getDocuments();
    final List<DocumentSnapshot> docList = querySnapshot.documents;
    final List<String> roomIdList =
        docList.map((doc) => doc.documentID).toList();
    final List roomList = roomIdList.map((roomId) async {
      final DocumentSnapshot room =
          await _db.collection('message/v1/rooms/$roomId').document().get();
      return Room.fromJson(room.data, roomId);
    }).toList();
    return roomList;
  }
}
