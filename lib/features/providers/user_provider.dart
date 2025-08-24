import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _displayName = "User";
  String _photoURL = "";

  String get displayName => _displayName;
  String get photoURL => _photoURL;

  void setDisplayName(String name) {
    _displayName = name;
    notifyListeners();
  }

  void setPhotoURL(String url) {
    _photoURL = url;
    notifyListeners();
  }
}
