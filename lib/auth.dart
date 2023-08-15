import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authstatechanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // If successful, the following line won't be executed
    } on FirebaseAuthException catch (e) {
      // Rethrow the FirebaseAuthException to be handled by the UI code
      rethrow;
    } catch (e) {
      // Handle other exceptions, if necessary
      print('An unexpected error occurred during sign-in: $e');
      throw e; // Rethrow the exception to be handled by the UI code
    }
  }

  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Set the user's displayName
        await user.updateDisplayName(username);

        // Store additional user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': username,
          'phoneNumber': phoneNumber,
        });

        return userCredential;
      }
    } on FirebaseAuthException catch (e) {
      // Handle authentication exceptions if needed
    }

    return null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> deleteUserAndFirestoreData() async {
    try {
      // Delete the user account from Firebase Authentication
      await currentUser?.delete();

      // Delete the corresponding data from Firestore
      await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).delete();
    } on FirebaseAuthException catch (e) {
      // Handle the exception if needed
      print('Error deleting user account: ${e.message}');
    }
  }
}
