import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:penstore/models/chat.dart';
import 'package:penstore/screens/chat/chat_detail_screen.dart';
import 'package:penstore/widgets/chat/chat_card.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
        child: Text("search bar")
        ),
        Expanded(child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatDetailScreen(),
                ),
              ),
            ),
          ),)
      ],
    );
  }
}