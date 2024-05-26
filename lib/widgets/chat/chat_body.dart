import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/chat/room_chat_controller.dart';
import 'package:penstore/models/chat.dart';
import 'package:penstore/widgets/chat/chat_card.dart';
import 'package:penstore/widgets/no_data.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final ChatRoomController chatRoomController = Get.put(ChatRoomController());

  // final FocusNode _searchFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (chatRoomController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (chatRoomController.chatRooms.isEmpty) {
        return const Column(
          children: [
            NoData(
              title: "Maaf, ",
              subTitle: "Anda belum punya riwayat chat",
              suggestion: "Silahkan tambahkan buau obrolan!",
            ),
            SizedBox(height: 20),
          ],
        );
      } else {
        return Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
            //   child: CustomTextField(
            //     focusNode: _searchFocusNode,
            //     hintText: "Cari chat",
            //     prefixIcon: 'search',
            //     keyboardType: TextInputType.text,
            //     controller: TextEditingController(),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: chatRoomController.chatRooms.length,
                itemBuilder: (context, index) {
                  final chatRoom = chatRoomController.chatRooms[index];

                  // get user data

                  print('room ${chatRoom.hasUnreadMessages}');
                  return ChatCard(
                    chat: chatsData[index],
                    roomChat: chatRoom,
                    recieverId: chatRoomController.recieverId.value,
                    isSeen:
                        chatRoomController.chatRooms[index].hasUnreadMessages,
                  );
                },
              ),
            )
          ],
        );
      }
    });
  }
}
