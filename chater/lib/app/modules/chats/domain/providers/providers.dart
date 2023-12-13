import 'package:chater/app/modules/chats/domain/models/user_model.dart';
import 'package:chater/app/modules/chats/domain/repo/chats_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final chatsRepositoryProvider = Provider((ref) => ChatsRepository());

final usersProvider = StreamProvider<List<User>>((ref) async* {
  final chatsRepo = ref.watch(chatsRepositoryProvider);
  while (true) {
    try {
      final userList = await chatsRepo.fetchRegisteredUsers();
      yield userList;
    } catch (e) {
      debugPrint('Error fetching users: $e');
      yield []; // or handle error differently
    }
  }
});
