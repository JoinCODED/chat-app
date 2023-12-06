import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthApi {
  setUserInformation(User userCred, String userName, String email) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.uid)
          .set(
        {
          'username': userName,
          'email': email,
        },
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

final authApi = AuthApi();
