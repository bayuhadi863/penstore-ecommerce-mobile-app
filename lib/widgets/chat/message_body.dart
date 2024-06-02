import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/chat/chat_controller.dart';
import 'package:penstore/controller/chat/room_chat_controller.dart';
import 'package:penstore/widgets/chat/message.dart';

class MessageBody extends StatelessWidget {
  MessageBody(
      {super.key,
      required this.roomId,
      required this.receiverId,
      required this.productId});
  final String roomId;
  final String receiverId;
  String productId;

  @override
  Widget build(BuildContext context) {
    final ChatRoomController chatRoomController = Get.put(ChatRoomController());
    final ChatController chatController = Get.put(ChatController(roomId));
    chatController.markMessagesAsSeen(roomId, receiverId);
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    // jika membawa produk
    if (productId.isNotEmpty) {
      chatController.writeProductMessage(
        productId,
      );
    }

    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: mediaQueryHeight * 0.9,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(50),
              top: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6BCCC9).withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          width: double.infinity,
          height: mediaQueryHeight * 0.9,
          margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          padding: EdgeInsets.only(bottom: mediaQueryHeight * 0.07),
          child: Obx(() {
            if (chatController.chats.isEmpty) {
              return const Center(child: Text('No chat available.'));
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      reverse: true,
                      itemCount: chatController.chats.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Message(
                        chat: chatController.chats[index],
                        userId: chatController.user!.uid,
                      ),
                    ),
                    SizedBox(height: mediaQueryHeight * 0.06),
                  ],
                ),
              );
            }
          }),
        ),
        if (productId.isNotEmpty) ...[
          Align(
            alignment: Alignment.bottomCenter,
            child: Text("Link Produk Tersematkan"),
          )
        ],
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF91E0DD).withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(1, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,
                      controller: chatController.messageController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xFFB3B3B3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xFFB3B3B3),
                          ),
                        ),
                        hintText: 'Tulis Pesanmu',
                        constraints: const BoxConstraints(
                          minHeight: 40,
                          maxHeight: 100,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (chatController.chat.value.productId != '') {
                              // langsung kirim Link product saat kirim pesan
                              chatController.chat.value.productId = productId;
                              chatController.sendProductMessage();
                              chatController.sendMessage();
                              productId = '';
                              chatRoomController.updatedAt(roomId);
                            } else {
                              // tanpa link product
                              chatController.sendMessage();
                              chatRoomController.updatedAt(roomId);
                            }
                          },
                          icon: Image.asset(
                            'assets/icons/send_outline.png',
                            width: 16,
                            height: 16,
                            color: const Color(0xFF6BCCC9),
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF424242),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
