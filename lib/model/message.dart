import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String text;
  DateTime sendTime;
  bool isMe;
  String senderId;
  String roomId;
  Message({
    this.text,
    this.sendTime,
    this.isMe,
    this.senderId,
    this.roomId,
  });

  factory Message.fromJson(Map<String, dynamic> json, String userId) {
    bool judgeIsMe(String senderId) {
      // 自分のIDと比較
      return senderId == userId;
    }

    return Message(
      text: json['text'].toString(),
      sendTime: (json['createdAt'] as Timestamp).toDate(),
      isMe: judgeIsMe(json['from'].toString()),
      senderId: json['from'].toString(),
      roomId: json['to'].toString(),
    );
  }
}
