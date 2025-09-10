import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier {
  String _displayName = "User";
  String _photoURL = "";

  String get displayName => _displayName;
  String get photoURL => _photoURL;

  // تهيئة البيانات عند بدء التطبيق
  Future<void> initializeUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // تحميل البيانات من Firestore أو FirebaseAuth
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        final data = userDoc.data();
        _displayName = data?['name'] ?? user.displayName ?? "User";
        _photoURL = data?['imageUrl'] ?? user.photoURL ?? "";
      } else {
        _displayName = user.displayName ?? "User";
        _photoURL = user.photoURL ?? "";
      }
      notifyListeners();
    }
  }

  void setDisplayName(String name) {
    _displayName = name;
    notifyListeners();
  }

  void setPhotoURL(String url) {
    _photoURL = url;
    notifyListeners();
  }

  void updatePhotoURL(String downloadURL) {
    _photoURL = downloadURL;
    notifyListeners();
  }

  void updateUserData({required String displayName, required String photoURL}) {
    _displayName = displayName;
    _photoURL = photoURL;
    notifyListeners();
  }
}
