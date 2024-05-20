import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:penstore/models/chatMessages.dart';
import 'package:penstore/widgets/chat/message.dart';

class MessageBody extends StatelessWidget {
  const MessageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              
            ),
            child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) => Message(message: demeChatMessages[index])),
          ),
        ),
      ],
    );
  }
}
