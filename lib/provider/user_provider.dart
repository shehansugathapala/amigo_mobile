import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    token: '', // Assuming this represents the authentication token
    password: '',
    isAdmin: false,
    serial: '', // Add serial property
  );

  User get user => _user;

  // Return properly typed userData
  User get userData => _user;

  String get serial => _user.serial; // Getter method for serial

  String get authToken => _user.token; // Getter method for authToken

  void setUser(Map<String, dynamic> userData) {
    // Update the user object with the provided userData
    _user = User.fromJson(userData);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    // Set user from an existing User object
    _user = user;
    notifyListeners();
  }
}
