import 'package:flutter/material.dart';
import 'package:penstore/models/chatMessages.dart';
import 'package:penstore/widgets/chat/text_message.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        default:
          return const SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10, vertical: 5,
      ),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // if (!message.isSender) ...[
          //   const CircleAvatar(
          //     radius: 12,
          //     backgroundImage: AssetImage("assets/images/profile.png"),
          //   ),
          //   const SizedBox(width: 10),
          // ],
          Column(
            children: [
              messageContaint(message),
            ],
          ),
        ], 
      ),
    );
  }
}
