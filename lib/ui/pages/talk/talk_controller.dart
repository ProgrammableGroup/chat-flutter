import 'package:flutter/material.dart';
import 'package:chat_flutter/model/room.dart';

class TalkController with ChangeNotifier {
  TalkController() {
    getRoomList();
  }
  List<Room> roomList;
  Future<void> getRoomList() async {
    roomList = [
      Room(
        id: 'roomId',
        name: 'Sport',
        imgUrl: 'https://prtimes.jp/i/24101/70/resize/d24101-70-320114-0.jpg',
        lastMessage: 'hello,group!',
        sendTime: '23:04',
      ),
      Room(
        id: 'roomId',
        name: 'Study',
        imgUrl: 'https://prtimes.jp/i/24101/70/resize/d24101-70-320114-0.jpg',
        lastMessage: 'hey!',
        sendTime: '21:04',
      ),
      Room(
        id: 'roomId',
        name: 'Hobby',
        imgUrl: 'https://prtimes.jp/i/24101/70/resize/d24101-70-320114-0.jpg',
        lastMessage: 'amusement Park!!!!',
        sendTime: '20:04',
      ),
    ];
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    notifyListeners();
  }
}
