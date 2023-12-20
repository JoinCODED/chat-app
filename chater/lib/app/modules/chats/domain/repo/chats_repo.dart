import 'package:chater/app/modules/chats/domain/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<MyUser>> fetchRegisteredUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      List<MyUser> userList = querySnapshot.docs
          .map((doc) => MyUser.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return userList;
    } catch (e) {
      debugPrint('Error fetching users: $e');
      return [];
    }
  }
}
