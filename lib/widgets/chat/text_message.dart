import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/chat/chat_controller.dart';
import 'package:penstore/models/chat_model.dart';

class TextMessage extends StatelessWidget {
  TextMessage({
    super.key,
    required this.message,
    required this.userId,
  });
  final ChatModel message;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width *
            0.75, // Maksimal 75% lebar layar
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: message.senderId == userId
            ? const Color(0xFF91E0DD).withOpacity(0.5)
            : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF91E0DD).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.message!,
            style: const TextStyle(
              color: Color(0xFF424242),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 5),
          // tanggal dan waktu
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "22/10/2004",
                style: TextStyle(
                  color: Color(0xFF757B7B),
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(width: 10),
              Text(
                "12:00 AM",
                style: TextStyle(
                  color: Color(0xFF757B7B),
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
