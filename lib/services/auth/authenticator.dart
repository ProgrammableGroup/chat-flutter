import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Authenticator {
  Authenticator() {
    _isSignIn.value = _firebaseUser.value != null;
    _firebaseAuth.onAuthStateChanged.pipe(_firebaseUser);
    _firebaseAuth.onAuthStateChanged
        .map((firebaseUser) => _firebaseUser != null)
        .pipe(_isSignIn);
  }

  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseUser = BehaviorSubject<FirebaseUser>();
  final _isSignIn = BehaviorSubject<bool>();

  ValueStream<FirebaseUser> get firebaseUser => _firebaseUser;
  ValueStream<bool> get isSignIn => _isSignIn;

  Future<FirebaseUser> fetchFirebaseUser() => _firebaseAuth.currentUser();

  Future<FirebaseUser> signUp(String email, String password) async {
    final current = await fetchFirebaseUser();
    if (current != null) {
      return current;
    }
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authResult?.user;
  }

  Future<FirebaseUser> signIn(String email, String password) async {
    final current = await fetchFirebaseUser();
    if (current != null) {
      return current;
    }

    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authResult?.user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> getUid() async {
    final current = await fetchFirebaseUser();
    if (current == null) {
      return '';
    }
    return current.uid;
  }

  void dispose() {
    _firebaseUser.close();
    _isSignIn.close();
  }
}
