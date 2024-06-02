import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/chat/room_chat_controller.dart';
import 'package:penstore/controller/profile/get_single_user_controller.dart';
import 'package:penstore/models/chat.dart';
import 'package:penstore/widgets/chat/chat_card.dart';
import 'package:penstore/widgets/no_data.dart';
import 'package:skeletons/skeletons.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final ChatRoomController chatRoomController = Get.put(ChatRoomController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (chatRoomController.isLoading.value) {
        return ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildSkeletonChatCard();
          },
        );
      } else if (chatRoomController.chatRooms.isEmpty) {
        return Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            const NoData(
              title: "Maaf, ",
              subTitle: "Anda belum punya riwayat chat",
              suggestion: "Silahkan tambahkan buau obrolan!",
            ),
          ],
        );
      } else {
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chatRoomController.chatRooms.length,
                itemBuilder: (context, index) {
                  final chatRoom = chatRoomController.chatRooms[index];
                  return ChatCard(
                    chat: chatsData[index],
                    roomChat: chatRoom,
                    recieverId: chatRoomController.recieverId.value,
                    isSeen:
                        chatRoomController.chatRooms[index].hasUnreadMessages,
                  );
                },
              )
            ],
          ),
        );
      }
    });
  }

  Widget _buildSkeletonChatCard() {
    return SkeletonItem(
      child: ListTile(
        leading: SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 50,
            height: 50,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        title: SkeletonLine(
          style: SkeletonLineStyle(
            height: 16,
            width: 120,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        subtitle: SkeletonLine(
          style: SkeletonLineStyle(
            height: 14,
            width: 200,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
