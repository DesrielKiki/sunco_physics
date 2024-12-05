import 'dart:io';
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
  ) async {
    try {
      await FirebaseFirestore.instance.collection('user_data').doc(userId).set({
        'user_email': email,
        'full_name': fullName,
        'username': username,
      });
    } catch (e) {
      throw Exception('Error saving user data');
    }
  }
}
