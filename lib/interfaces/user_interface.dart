import '../model/user.dart';

abstract class UserInterface {
  Future<User> getUserById(String userId);
}
