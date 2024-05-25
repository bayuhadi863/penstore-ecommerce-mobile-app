import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:penstore/models/chat.dart';
import 'package:penstore/screens/chat/chat_detail_screen.dart';
import 'package:penstore/widgets/chat/chat_card.dart';
import 'package:penstore/widgets/text_form_field.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final FocusNode _searchFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
          child: CustomTextField(
            focusNode: _searchFocusNode,
            hintText: "Cari chat",
            prefixIcon: 'search',
            keyboardType: TextInputType.text,
            controller: TextEditingController(),
          ),
        ),
        Expanded(
          child: ListView.builder(
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
          ),
        )
      ],
    );
  }
}
