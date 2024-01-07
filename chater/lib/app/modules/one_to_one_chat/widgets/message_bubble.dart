import 'package:chater/app/core/constants/my_colors.dart';
import 'package:chater/app/core/extensions/context_extension.dart';
import 'package:chater/app/modules/one_to_one_chat/domain/models/message.dart';
import 'package:chater/app/modules/one_to_one_chat/domain/providers/message_providers.dart';
import 'package:chater/app/utils/datetime_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageBubble extends StatelessWidget with CustomDateTimeFormatter {
  final Message message;

  const MessageBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            message.senderId == FirebaseAuth.instance.currentUser!.uid
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                message.senderId == FirebaseAuth.instance.currentUser!.uid
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Consumer(builder: (context, ref, child) {
                  final messageProvider =
                      ref.watch(chatMessageStateNotifierProvider);
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: message.senderId ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? Colors.blue[100]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                        bottomLeft: message.senderId ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? const Radius.circular(15)
                            : const Radius.circular(0),
                        bottomRight: message.senderId ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? const Radius.circular(0)
                            : const Radius.circular(15),
                      ),
                    ),
                    child: messageProvider.isLoading &&
                            messageProvider.message.startsWith('https')
                        ? SizedBox(
                            width: context.screenWidth * 0.1,
                            height: context.screenHeight * 0.1,
                            child: const Center(
                                child: CircularProgressIndicator()))
                        : message.message.startsWith("https")
                            ? Image.network(
                                message.message,
                                height: context.screenHeight * 0.25,
                                width: context.screenWidth * 0.3,
                              )
                            : Text(
                                message.message,
                                style: context.textTheme.bodyMedium?.copyWith(
                                    color: message.senderId ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? Colors.black
                                        : Colors.black87),
                              ),
                  );
                }),
              ),
            ],
          ),
          Text(
            formatChatDateTime(message.timestamp, context),
            style: context.textTheme.bodySmall
                ?.copyWith(color: MyColors.greyscale_500),
          ),
        ],
      ),
    );
  }
}
