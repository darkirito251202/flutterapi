import 'package:flutter/material.dart';

class AuthManager {
  static String? userEmail;

  static void setUserEmail(String email) {
    userEmail = email;
  }

  static void signOut() {
    userEmail = null;
  }
}
