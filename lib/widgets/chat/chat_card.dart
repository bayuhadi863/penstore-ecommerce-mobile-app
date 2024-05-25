import 'package:flutter/material.dart';
import 'package:penstore/models/chat.dart';

// import '../../../constants.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
    required this.press,
  }) : super(key: key);

  final Chat chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
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
                  Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF91E0DD).withOpacity(0.5),
                        blurRadius: 16,
                        offset: const Offset(1, 1),
                      ),
                    ]),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(chat.image),
                    ),
                  ),
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
                              text: chat.name,
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
                              text: chat.lastMessage,
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
                        text: const TextSpan(
                            text: "23 April 2024, 14:00 AM",
                            style: TextStyle(
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
                  Opacity(
                    opacity: 0.64,
                    child: Text(chat.time),
                  ),
                  Container(
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
                        'assets/icons/delete_icon.png',
                        height: 16,
                        width: 16,
                        filterQuality: FilterQuality.high,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
