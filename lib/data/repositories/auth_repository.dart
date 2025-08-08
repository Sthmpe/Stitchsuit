import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Sign up with email and password
  Future<void> signUp(String email, String password, String name) async {
    try {
      // Create user with Firebase Auth
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Store user info in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'role': 'customer',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Login with email and password
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Handle Firebase Auth errors
  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'An account already exists for that email.';
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided.';
        case 'invalid-email':
          return 'The email address is invalid.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'too-many-requests':
          return 'Too many requests. Try again later.';
        default:
          return 'Authentication failed: ${error.message}';
      }
    }
    return 'An unexpected error occurred.';
  }
}
