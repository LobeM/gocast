import 'package:firebase_auth/firebase_auth.dart';
import 'package:gocast/utils/localized_exception_extension.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  String getUser() => (_firebaseAuth.currentUser).email;

  Future<void> signOut() async => Future.wait([_firebaseAuth.signOut()]);

  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.toLocalizedString();
    }
  }

  Future<String> signUp({
    String fullName,
    String email,
    String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.toLocalizedString();
    }
  }
}
