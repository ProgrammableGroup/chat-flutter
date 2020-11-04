import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  HomeController(this.authenticator) {
    currentIndex = 0;
    authenticator.isSignIn.listen((value) {
      _isSignIn = value;
    });
  }

  final Authenticator authenticator;
  int currentIndex;

  bool _isSignIn;
  bool get isSignIn => _isSignIn;

  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
