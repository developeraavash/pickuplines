import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickuplines/features/auth/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      if (email.isEmpty || !email.contains('@')) {
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'The email address is badly formatted.',
        );
      }

      if (password.isEmpty) {
        throw FirebaseAuthException(
          code: 'weak-password',
          message: 'The password is invalid.',
        );
      }

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _userService.updateLastLogin(credential.user!.uid);
      }

      return credential;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw FirebaseAuthException(
        code: 'unknown',
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  // Sign up with email and password
  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _userService.createOrUpdateUser(
          uid: credential.user!.uid,
          email: email,
          displayName: credential.user!.displayName,
          photoURL: credential.user!.photoURL,
        );
      }

      return credential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in anonymously (guest mode)
  Future<UserCredential> signInAnonymously() async {
    try {
      final credential = await _auth.signInAnonymously();

      if (credential.user != null) {
        await _userService.createOrUpdateUser(
          uid: credential.user!.uid,
          email: 'guest',
          displayName: 'Guest User',
        );
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'operation-not-allowed') {
        throw FirebaseAuthException(
          code: 'guest-disabled',
          message: 'Guest login is not enabled. Please sign up or login.',
        );
      }
      rethrow;
    } catch (e) {
      throw FirebaseAuthException(
        code: 'unknown',
        message: 'Failed to continue as guest. Please try again.',
      );
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
