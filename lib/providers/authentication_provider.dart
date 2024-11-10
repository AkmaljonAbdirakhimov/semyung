import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      } else if (e.code == "invalid-credential") {
        throw ("Login yoki parol xato");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  Stream<User?> checkUser() async* {
    yield* _firebaseAuth.authStateChanges();
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
