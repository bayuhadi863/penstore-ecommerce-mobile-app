import 'package:flutter/material.dart';
import 'package:penstore/widgets/chat/appBar_detail_chat.dart';
import 'package:penstore/widgets/chat/message_body.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
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
        title: const AppBarDetailChat(),
      ),
      body: MessageBody(),
    );
  }
}
