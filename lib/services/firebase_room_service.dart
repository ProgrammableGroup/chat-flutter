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

  Future<void> setMyRoomSetting(String userId, String roomId) async {
    final settingData = {
      'allowNotification': false,
    };

    await _db
        .collection('message/v1/users/$userId/room_setting')
        .document(roomId)
        .setData(settingData);
  }

  Future<void> updateRoomData(Room room) async {
    final Map<String, String> roomData = {
      'name': room.name,
      'imgUrl': room.imgUrl,
    };
    await _db
        .collection('message/v1/rooms')
        .document(room.id)
        .updateData(roomData);
  }

  Future<void> setMyLastReadTime(String roomId, String userId) async {
    final timeData = {
      'lastReadTime': FieldValue.serverTimestamp(),
    };
    await _db
        .collection('message/v1/rooms/$roomId/members')
        .document('$userId')
        .setData(timeData);
  }

  Stream<List<DateTime>> getLastReadTimeList(String roomId) {
    final Stream<QuerySnapshot> querySnapshot = _db
        .collection('message/v1/rooms/$roomId/members')
        .orderBy('lastReadTime', descending: false)
        .snapshots();
    return querySnapshot.map((snapshot) {
      return snapshot.documents.map((doc) {
        return (doc.data['lastReadTime'] as Timestamp).toDate();
      }).toList();
    });
  }

  Future<List<Room>> getMyRoomList(String uid) async {
    final QuerySnapshot querySnapshot = await _db
        .collection('message/v1/users/$uid/room_setting')
        .getDocuments();
    final List<DocumentSnapshot> docList = querySnapshot.documents;
    final List<String> roomIdList =
        docList.map((doc) => doc.documentID).toList();
    final List<Room> roomList = [];
    for (final String roomId in roomIdList) {
      final DocumentSnapshot roomData =
          await _db.collection('message/v1/rooms').document('$roomId').get();
      roomList.add(Room.fromJson(roomData.data, roomId));
    }
    //時間順に並び替え
    roomList.sort((a, b) {
      final aTime = a.lastMessage['createdAt'] as Timestamp;
      final bTime = b.lastMessage['createdAt'] as Timestamp;
      if (aTime.compareTo(bTime) > 0) {
        return -1;
      } else {
        return 1;
      }
    });
    return roomList;
  }
}
