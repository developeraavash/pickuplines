import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pickuplines/features/auth/services/user_service.dart';
import 'package:pickuplines/firebase_options.dart';

class AuthService {
  late final FirebaseAuth _auth;
  late final UserService _userService;
  bool _initialized = false;

  AuthService() {
    _init();
  }

  Future<void> _init() async {
    if (_initialized) return;
    
    try {
      print('Initializing AuthService...');
      
      // Ensure Firebase is initialized
      if (Firebase.apps.isEmpty) {
        print('Firebase not initialized, initializing now...');
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        print('Firebase core initialized');
      }
      
      print('Getting Firebase Auth instance...');
      _auth = FirebaseAuth.instance;
      
      // Verify Firebase Auth is working
      try {
        await _auth.authStateChanges().first;
        print('Firebase Auth verified working');
      } catch (authError) {
        print('Firebase Auth verification failed: $authError');
        throw FirebaseAuthException(
          code: 'auth-init-failed',
          message: 'Failed to initialize authentication. Please restart the app.',
        );
      }
      
      _userService = UserService();
      _initialized = true;
      print('AuthService initialized successfully');
    } catch (e, stack) {
      print('AuthService initialization error: $e');
      print('Stack trace: $stack');
      _initialized = false;
      rethrow;
    }
  }

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
      if (!_initialized) {
        print('AuthService not initialized, initializing now...');
        await _init();
      }

      print('Starting login process...');
      
      if (email.isEmpty || !email.contains('@')) {
        print('Invalid email format');
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'The email address is badly formatted.',
        );
      }

      if (password.isEmpty) {
        print('Empty password');
        throw FirebaseAuthException(
          code: 'weak-password',
          message: 'The password is invalid.',
        );
      }

      // Wait for Firebase Auth to be ready
      await Future.delayed(const Duration(milliseconds: 500));
      
      print('Attempting Firebase login...');
      
      try {
        final credential = await _auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password,
        ).timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            throw FirebaseAuthException(
              code: 'timeout',
              message: 'Login request timed out. Please try again.',
            );
          },
        );

        if (credential.user == null) {
          print('Error: Firebase returned null user');
          throw FirebaseAuthException(
            code: 'null-user',
            message: 'Login failed. Please try again.',
          );
        }

        print('Login successful for user: ${credential.user!.uid}');
        
        try {
          await _userService.updateLastLogin(credential.user!.uid);
          print('Updated last login timestamp');
        } catch (e) {
          print('Warning: Failed to update last login: $e');
          // Don't throw - this is not critical
        }

        return credential;
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuthException during auth: ${e.code}');
        print('Error message: ${e.message}');
        rethrow;
      } catch (e) {
        print('Platform error during login: $e');
        if (e.toString().contains('PigeonUserDetails')) {
          // Handle the specific platform error
          await Future.delayed(const Duration(seconds: 1));
          final user = _auth.currentUser;
          if (user != null) {
            print('User is actually signed in despite platform error');
            // Try signing in again
            return await _auth.signInWithEmailAndPassword(
              email: email.trim(),
              password: password,
            );
          }
        }
        rethrow;
      }
    } catch (e, stack) {
      print('Error in auth service: $e');
      print('Stack trace: $stack');
      rethrow;
    } finally {
      print('==== Login process completed ====');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      print('Signing out user...');
      await _auth.signOut();
      print('User signed out successfully');
    } catch (e, stack) {
      print('Error signing out: $e');
      print('Stack trace: $stack');
      rethrow;
    }
  }

  // Sign up with email and password
  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      if (!_initialized) {
        print('AuthService not initialized, initializing now...');
        await _init();
      }

      print('Starting sign up process...');
      
      if (email.isEmpty || !email.contains('@')) {
        print('Invalid email format');
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'The email address is badly formatted.',
        );
      }

      if (password.isEmpty || password.length < 6) {
        print('Password too weak');
        throw FirebaseAuthException(
          code: 'weak-password',
          message: 'The password must be at least 6 characters.',
        );
      }

      try {
        print('Attempting to create user account...');
        final credential = await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );

        if (credential.user == null) {
          print('Error: Firebase returned null user after creation');
          throw FirebaseAuthException(
            code: 'null-user',
            message: 'Failed to create account. Please try again.',
          );
        }

        print('Account created successfully for user: ${credential.user!.uid}');
        
        try {
          await _userService.createOrUpdateUser(
            uid: credential.user!.uid,
            email: email,
            displayName: credential.user!.displayName,
            photoURL: credential.user!.photoURL,
          );
          print('User profile created in Firestore');
        } catch (e) {
          print('Warning: Failed to create user profile: $e');
          // Don't throw - the account was still created
        }

        return credential;
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuthException during sign up: ${e.code}');
        print('Error message: ${e.message}');
        
        if (e.code == 'email-already-in-use') {
          throw FirebaseAuthException(
            code: 'email-already-in-use',
            message: 'An account already exists with this email. Please sign in.',
          );
        }
        rethrow;
      } catch (e) {
        print('Unexpected error during sign up: $e');
        if (e.toString().contains('PigeonUserDetails')) {
          // Handle the specific platform error
          await Future.delayed(const Duration(seconds: 1));
          final user = _auth.currentUser;
          if (user != null) {
            print('User account was actually created despite platform error');
            return await _auth.signInWithEmailAndPassword(
              email: email.trim(),
              password: password,
            );
          }
        }
        rethrow;
      }
    } catch (e, stack) {
      print('Error in auth service during sign up: $e');
      print('Stack trace: $stack');
      rethrow;
    }
  }
}
