import 'package:chater/app/modules/one_to_one_chat/domain/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            message.senderId == FirebaseAuth.instance.currentUser!.uid
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    message.senderId == FirebaseAuth.instance.currentUser!.uid
                        ? Colors.blue[100]
                        : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  topRight: const Radius.circular(15),
                  bottomLeft:
                      message.senderId == FirebaseAuth.instance.currentUser!.uid
                          ? const Radius.circular(15)
                          : const Radius.circular(0),
                  bottomRight:
                      message.senderId == FirebaseAuth.instance.currentUser!.uid
                          ? const Radius.circular(0)
                          : const Radius.circular(15),
                ),
              ),
              child: Text(
                message.message,
                style: TextStyle(
                  color:
                      message.senderId == FirebaseAuth.instance.currentUser!.uid
                          ? Colors.black
                          : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
