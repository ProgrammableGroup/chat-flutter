import 'package:chat_flutter/model/user.dart';
import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/services/firebase_user_service.dart';
import 'package:flutter/material.dart';

class SelectMemberController extends ChangeNotifier {
  SelectMemberController(this.authenticator);
  /*{
    getAllUserExceptMe();
  }*/

  List<User> members = [];
  List<User> searchedUserList = [];
  final Authenticator authenticator;

  void addMember(User user) {
    for (final member in members) {
      if (member.id == user.id) {
        return;
      }
    }
    members.add(user);
    notifyListeners();
  }

  void removeMember(User user) {
    members.remove(user);
    notifyListeners();
  }

  /*Future<void> getAllUserExceptMe() async {
    final List<User> allUserList = await FirebaseUserService().getAllUser();
    // 自分のIDを除く
    final String myId = await authenticator.getUid();
    searchedUserList = allUserList.where((user) => user.id != myId).toList();
    notifyListeners();
  }*/

  Future<void> getSearchedUserExceptMe(String name) async {
    final List<User> userList =
        await FirebaseUserService().getSearchedUser(name);
    final String myId = await authenticator.getUid();
    searchedUserList = userList.where((user) => user.id != myId).toList();
    notifyListeners();
  }

  void searchUser(String id) {}
}
