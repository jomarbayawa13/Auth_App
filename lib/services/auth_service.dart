import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> signIn({
    required String email,
    required String password,
  }) async
     
     try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return null;
    } on FirebaseAuthException catch(e) {
       return _handleAuthException(e);

    }


    String _handleAuthException (FirebaseAuthException e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email';
        case 'wrong-password:
          return 'wrong password provided';
        case 'email-already-in-use':
          return 'An account already exists with this email';
        case 'invalid-email':
          return 'the email address is invalid';
        case 'weak-password':
          return 'The password is too weak';
        case 'Operation -not-allowed':
          return 'Operation not allowed. Please contact chat-gpt';       
        case 'user-disable':
          return 'This user account has been disabled';
        default:
          return 'An error occured. Please try again!.';           
      }
    }

}