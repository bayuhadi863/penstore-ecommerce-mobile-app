import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:penstore/models/chatMessages.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF6BCCC9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message!.text,
        style: TextStyle(
          color: message!.isSender
              ? Colors.black
              : Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
    );
  }
}
