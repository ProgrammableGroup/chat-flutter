import 'package:chat_flutter/interfaces/message_interface.dart';
import 'package:chat_flutter/model/message.dart';
import 'package:chat_flutter/services/firebase_message_service.dart';

class MessageService implements MessageInterface {
  @override
  Future<void> sendMessage(String text, String roomId, String senderId) async {
    final Message message = Message(
      text: text,
      senderId: senderId,
      roomId: roomId,
    );
    await FirebaseMessageService().setMessageData(message);
  }

  @override
  Stream<List<Message>> getMessage(String roomId, String userId) {
    return FirebaseMessageService().getMessageData(roomId, userId);
  }
}
