import 'package:chat_flutter/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserService {
  final Firestore _db = Firestore.instance;
  Future<void> setUserData(String name, String uid) async {
    final userData = {
      'name': name,
      'profileImageURL': '',
    };
    await _db.collection('message/v1/users').document('$uid').setData(userData);
  }

  Future<void> updateUserData(User user) async {
    final Map<String, String> userData = {
      'name': user.name,
      'profileImageURL': user.imgUrl,
    };
    await _db
        .collection('message/v1/users')
        .document(user.id)
        .updateData(userData);
  }

  Future<User> getUserData(String uid) async {
    final DocumentSnapshot result =
        await _db.collection('message/v1/users').document('$uid').get();
    final Map<String, dynamic> user = result.data;
    return User.fromJson(user, uid);
  }

  Future<String> getUserImgUrl(String uid) async {
    final DocumentSnapshot result =
        await _db.collection('message/v1/users').document('$uid').get();
    return result.data['profileImageURL'].toString();
  }

  /*Future<List<User>> getAllUser() async {
    final QuerySnapshot result =
        await _db.collection('message/v1/users').getDocuments();

    return result.documents.map((doc) {
      final Map<String, dynamic> user = doc.data;
      return User.fromJson(user, doc.documentID);
    }).toList();
  }*/

  Future<List<User>> getSearchedUser(String name) async {
    final startAt = [name];
    final endAt = ['$name\uf8ff'];
    final QuerySnapshot result = await _db
        .collection('message/v1/users')
        .orderBy('name')
        .startAt(startAt)
        .endAt(endAt)
        .getDocuments();
    return result.documents.map((doc) {
      final Map<String, dynamic> user = doc.data;
      return User.fromJson(user, doc.documentID);
    }).toList();
  }
}
