import 'package:flutter/material.dart';
import 'package:penstore/widgets/chat/appbar_chat.dart';
import 'package:penstore/widgets/chat/chat_body.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 74,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const AppBarChat(),
        ),
        body: const ChatBody());
  }
}
