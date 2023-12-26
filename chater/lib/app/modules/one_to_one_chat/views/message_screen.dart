import 'package:chater/app/modules/chats/domain/models/user_model.dart';
import 'package:chater/app/modules/one_to_one_chat/domain/providers/message_providers.dart';
import 'package:chater/app/modules/one_to_one_chat/widgets/message_body_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OneToOneMessagingScreen extends ConsumerWidget {
  final MyUser user;

  const OneToOneMessagingScreen({super.key, required this.user});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagingRepo = ref.read(messagingProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username.toString()),
      ),
      body: MessagingBodyView(selectedUser: user, messagingRepo: messagingRepo),
    );
  }
}
