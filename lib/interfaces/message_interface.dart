import 'package:chat_flutter/model/message.dart';

abstract class MessageInterface {
  Future<void> sendMessage(String text, String roomId, String senderId);

  Stream<List<Message>> getMessage(String roomId, String userId);
}
