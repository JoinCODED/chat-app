import 'package:chater/app/core/extensions/context_extension.dart';
import 'package:chater/app/modules/chats/domain/models/user_model.dart';
import 'package:chater/app/modules/one_to_one_chat/domain/models/message.dart';
import 'package:chater/app/modules/one_to_one_chat/domain/repo/message_repo.dart';
import 'package:chater/app/modules/one_to_one_chat/widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessagingView extends StatefulWidget {
  final MyUser selectedUser;
  final MessagingRepository messagingRepo;

  const MessagingView({
    super.key,
    required this.selectedUser,
    required this.messagingRepo,
  });

  @override
  State<MessagingView> createState() => _MessagingViewState();
}

class _MessagingViewState extends State<MessagingView> {
  final _sendMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<Message>>(
            stream: widget.messagingRepo.messagesStream(
              senderId: FirebaseAuth.instance.currentUser!.uid,
              receiverId: widget.selectedUser.userId,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return Center(
                    child: Text('Error fetching messages: ${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final messages = snapshot.data ?? [];
              return ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) =>
                    MessageBubble(message: messages[index]),
              );
            },
          ),
        ),
        _buildMessageInput(context, widget.selectedUser.userId),
      ],
    );
  }

  Widget _buildMessageInput(BuildContext context, String userId) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _sendMessageController,
              decoration: const InputDecoration(hintText: 'Type your message'),
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                await widget.messagingRepo
                    .sendMessage(
                  senderId: FirebaseAuth.instance.currentUser!.uid,
                  receiverId: userId,
                  message: _sendMessageController.text,
                )
                    .whenComplete(() {
                  _sendMessageController.clear();
                });
              } catch (e) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  context.showSnackbar(
                    'Error sending message: $e',
                  );
                });
              }
            }, // Implement send button functionality
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
