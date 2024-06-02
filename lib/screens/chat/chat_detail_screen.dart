import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/profile/get_single_user_controller.dart';
import 'package:penstore/widgets/chat/appBar_detail_chat.dart';
import 'package:penstore/widgets/chat/message_body.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  String? roomId;
  String? recieverId;
  String? productId;

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic> arguments = Get.arguments;
    roomId = arguments['roomChatId'];
    recieverId = arguments['recieverId'];
    productId = arguments['productId'];

    // GetSingleUserController(recieverId!);
  }

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
        title: AppBarDetailChat(
          roomId: roomId!,
          recieverName: "Seller",
        ),
      ),
      body: MessageBody(
        roomId: roomId!,
        receiverId: recieverId!,
        productId: productId!,
      ),
    );
  }
}
