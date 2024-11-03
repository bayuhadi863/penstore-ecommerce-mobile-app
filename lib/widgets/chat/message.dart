import 'package:flutter/material.dart';
import 'package:penstore/models/chat_model.dart';
import 'package:penstore/widgets/chat/product_message.dart';
import 'package:penstore/widgets/chat/text_message.dart';

class Message extends StatelessWidget {
  Message({
    super.key,
    required this.chat,
    required this.userId,
  });
  final ChatModel chat;
  final String userId;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatModel message, String userId) {
      if (message.productId != "" && message.productId != null) {
        return ProductMessage(message: message, userId: userId);
      } else if (message.productId != null && message.productId == '') {
        return TextMessage(message: message, userId: userId);
      } else {
        return Text('pesan tidak dapat dmuat ${message.productId}');
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: chat.senderId == userId
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
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
              messageContaint(chat, userId),
            ],
          ),
        ],
      ),
    );
  }
}
