// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:penstore/controller/profile/get_single_user_controller.dart';

import 'package:penstore/models/roomChat_model.dart';

// import '../../../constants.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.roomChat,
    required this.isSeen,
    required this.recieverId,
    required chat,
  });

  final RoomChatModel roomChat;
  final bool isSeen;
  final String recieverId;

  @override
  Widget build(BuildContext context) {
    final userIds = roomChat.userId;
    final authUserId = FirebaseAuth.instance.currentUser!.uid;

    final partnerId = userIds[0] == authUserId ? userIds[1] : userIds[0];

    final GetSingleUserController getSingleUserController =
        Get.put(GetSingleUserController(partnerId), tag: partnerId);

    return InkWell(
      onTap: () {
        Get.toNamed('/detail-chat', arguments: {
          'roomChatId': roomChat.id,
          'recieverId': recieverId,
          'productId': '',
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 96,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF91E0DD).withOpacity(0.5),
                blurRadius: 16,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Obx(() {
                    final user = getSingleUserController.user.value;
                    return Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF91E0DD).withOpacity(0.5),
                          blurRadius: 16,
                          offset: const Offset(1, 1),
                        ),
                      ]),
                      child: user.imageUrl == '' || user.imageUrl == null
                          ? const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/profile.jpeg'),
                            )
                          : CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(user.imageUrl!),
                            ),
                    );
                  }),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: roomChat.senderName,
                              style: const TextStyle(
                                color: Color(0xFF424242),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          RichText(
                            text: TextSpan(
                              text: roomChat.lastMessage,
                              style: const TextStyle(
                                color: Color(0xFF757B7B),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                            text: DateFormat('MMMM d, yyyy hh:mm a')
                                .format(roomChat.updatedAt!),
                            style: const TextStyle(
                              color: Color(0xFF6BCCC9),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Opacity(
                    opacity: 0.64,
                    child: Text(''),
                  ),
                  isSeen
                      ? Container(
                          width: 26,
                          height: 26,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF46B69).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/icons/info_outline.png',
                              height: 16,
                              width: 16,
                              filterQuality: FilterQuality.high,
                              color: const Color(0xFFF46B69).withOpacity(1),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.all(0),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
