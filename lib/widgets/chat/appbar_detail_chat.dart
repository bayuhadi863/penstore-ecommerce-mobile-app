import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/chat/chat_controller.dart';
import 'package:penstore/controller/profile/user_controller.dart';

class AppBarDetailChat extends StatelessWidget {
  AppBarDetailChat({
    required this.roomId,
    required this.recieverName,
    super.key,
  });
  final String roomId;
  final String recieverName;

  @override
  Widget build(BuildContext context) {
    // final ChatController chatController = Get.put(ChatController(roomId));

    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //icon menu
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF91E0DD).withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: Color(0xFF6BCCC9),
                ),
              ),
            ),
            Container(
              width: mediaQueryWidth * 0.60,
              height: mediaQueryHeight * 0.055,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: recieverName,
                        style: TextStyle(
                          color: Color(0xFF424242),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        text: 'Active lately',
                        style: TextStyle(
                          color: Color(0xFF757B7B),
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
          ],
        ),
      ),
    );
  }
}
