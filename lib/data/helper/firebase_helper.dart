import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUserData(
    String userId,
    String fullName,
    String username,
    String email,
    String gender,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('user_data').doc(userId).set({
        'full_name': fullName,
        'username': username,
        'user_email': email,
        'user_gender': gender
      });
    } catch (e) {
      throw Exception('Error saving user data');
    }
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      String userId) async {
    return await _firestore.collection('user_data').doc(userId).get();
  }

  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    await _firestore.collection('user_data').doc(userId).update(data);
  }

  Future<bool> verifyPassword(String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
          code: 'user-not-found', message: 'User not found');
    }

    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: oldPassword,
    );
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }
}
